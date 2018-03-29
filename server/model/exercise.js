module.exports = (sql, SQL) => sql.define('exercise', {
  id: { type: SQL.INTEGER, autoIncrement: true, primaryKey: true },
  name: { type: SQL.TEXT },
  description: { type: SQL.TEXT },
  springs: { type: SQL.TEXT },
  photo: { type: SQL.TEXT },
  video: { type: SQL.TEXT },
});