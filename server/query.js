const database = require('./database');
const log = require('./log');

let sql;

database.then(sq => sql = sq);

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

module.exports = {
  select (sqlQuery, data) {
    return query(sqlQuery, data);
  },
  insert (sqlQuery, data) {
    const tableName = sqlQuery.match(/^insert into ([a-z_0-9]+)/i);
    sqlQuery += `select currval('${tableName[1]}_id_seq');`;
    return query(sqlQuery, data, sql.QueryTypes.INSERT).then(result => {
      return parseFloat(result[0][0].currval);
    });
  }
};