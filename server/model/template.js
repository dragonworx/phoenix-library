module.exports = (sql, SQL) => sql.define('template', {
  id: { type: SQL.INTEGER, autoIncrement: true, primaryKey: true },
  categories: { type: SQL.TEXT },
});