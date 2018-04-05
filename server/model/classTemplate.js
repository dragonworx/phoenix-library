module.exports = (sql, SQL) => sql.define('classTemplate', {
  id: { type: SQL.INTEGER, autoIncrement: true, primaryKey: true },
  genreId: { type: SQL.INTEGER },
  templateId: { type: SQL.TEXT },
});