module.exports = (sql, SQL) => sql.define('class', {
  id: { type: SQL.INTEGER, autoIncrement: true, primaryKey: true },
  name: { type: SQL.TEXT },
  status: { type: SQL.TEXT },
  genreId: { type: SQL.INTEGER },
  createdBy: { type: SQL.INTEGER },
  notes: { type: SQL.TEXT },
  categorySummary: { type: SQL.TEXT },
  durationSummary: { type: SQL.INTEGER },
  revision: { type: SQL.TEXT, defaultValue: 1 },
});