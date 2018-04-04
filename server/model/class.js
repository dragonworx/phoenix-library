module.exports = (sql, SQL) => sql.define('class', {
  id: { type: SQL.INTEGER, autoIncrement: true, primaryKey: true },
  name: { type: SQL.TEXT },
  status: { type: SQL.INTEGER },
  labelId: { type: SQL.INTEGER },
  designerId: { type: SQL.INTEGER },
  notes: { type: SQL.TEXT },
});