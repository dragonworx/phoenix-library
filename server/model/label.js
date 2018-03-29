module.exports = (sql, SQL) => sql.define('label', {
  id: { type: SQL.INTEGER, autoIncrement: true, primaryKey: true },
  type: { type: SQL.INTEGER },
  name: { type: SQL.TEXT },
  description: { type: SQL.TEXT },
  color: { type: SQL.TEXT },
});