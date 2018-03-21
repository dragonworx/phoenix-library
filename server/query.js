const database = require('./database');
const log = require('./log');

let sql;

function query (sqlQuery, data = null, type = sql.QueryTypes.SELECT) {
  const options = {
    raw: true,
    type
  };
  if (data) {
    options.replacements = data;
  }
  log(sqlQuery, 'cyan');
  return sql.query(sqlQuery, options);
}

function onError(error) {
  log('Database Query Error:', 'red');
  if (error.stack) {
    log(error.stack, 'red');
  } else {
    log(error.original.sql, 'red');
    log('-'.repeat(error.original.position - 1) + '^', 'red');
  }
  return Promise.reject();
}

const exported = {
  /**
   * RAW
   * @param {string} sqlQuery 
   * @param {{}|[]} data
   * @param {string?} type
   */
  raw (sqlQuery, data, type) {
    return query(sqlQuery, data, type);
  },
  /**
   * SELECT
   * @param {string} tableName
   * @param {[]} columns 
   * @param {{}?} filter 
   */
  select (tableName, columns, filter, orderBy = 'id') {
    const where = filter ? 
      ' WHERE ' + Object.keys(filter).map(k => `${k} = :${k}`).join(' AND ')
      : '';
    const sqlQuery = `SELECT ${columns.join(', ')} FROM ${tableName}${where} ORDER BY ${orderBy};`;
    return this.selectRaw(sqlQuery, filter);
  },
  selectRaw (sqlQuery, data) {
    return query(sqlQuery, data, sql.QueryTypes.SELECT)
    .then(rows => {
      return rows;
    }).catch(onError);
  },
  /**
   * INSERT
   * @param {string} tableName 
   * @param {{}} data 
   */
  insert (tableName, data) {
    const columns = Object.keys(data);
    const values = columns.map(k => `:${k}`);
    const sqlQuery = `INSERT INTO ${tableName} (${columns.join(', ')}) values (${values.join(', ')}); select currval('${tableName}_id_seq');`;
    return this.insertRaw(sqlQuery, data)
      .then(id => {
        log('> ' + id);
        return id;
      });
  },
  insertRaw (sqlQuery, data) {
    return query(sqlQuery, data, sql.QueryTypes.INSERT)
    .then(result => {
      return parseFloat(result[0][0].currval);
    }).catch(onError);
  },
  /**
   * INSERT multiple
   * @param {string} tableName 
   * @param {[]} data 
   */
  inserts (tableName, dataArray) {
    return Promise.all(dataArray.map(data => this.insert(tableName, data)));
  },
  /**
   * UPDATE
   * @param {string} tableName 
   * @param {{}} data 
   * @param {{}?} filter 
   */
  update (tableName, data, filter) {
    const columns = Object.keys(data);
    const values = columns.map(k => `:${k}`);
    const where = filter ? 
    ' WHERE ' + Object.keys(filter).map(k => {
      data[k] = filter[k];
      return `${k} = :${k}`;
    }).join(' AND ')
    : '';
    const OB = columns.length === 1 ? '' : '(';
    const CB = columns.length === 1 ? '' : ')';
    const sqlQuery = `UPDATE ${tableName} SET ${OB}${columns.join(', ')}${CB} = ${OB}${values.join(', ')}${CB}${where};`;
    return this.updateRaw(sqlQuery, data);
  },
  updateRaw (sqlQuery, data) {
    return query(sqlQuery, data, sql.QueryTypes.UPDATE)
      .then(result => {
        return result[1];
      }).catch(onError);
  },
  /**
   * DELETE
   * @param {string} tableName
   * @param {[]} ids 
   */
  remove (tableName, ids, idColumn = 'id') {
    const sqlQuery = `DELETE FROM ${tableName} WHERE ${idColumn} IN(:ids)`;
    return this.removeRaw(sqlQuery, { ids });
  },
  removeRaw (sqlQuery, data) {
    return query(sqlQuery, data, sql.QueryTypes.DELETE).catch(onError);
  },
  clear (tableName) {
    const sqlQuery = `TRUNCATE ${tableName}`;
    return query(sqlQuery);
  },
};

database.then(sq => {
  sql = sq;
  exported.SELECT = sql.QueryTypes.SELECT;
  exported.INSERT = sql.QueryTypes.INSERT;
  exported.UPDATE = sql.QueryTypes.UPDATE;
  exported.DELETE = sql.QueryTypes.DELETE;
});

module.exports = exported;