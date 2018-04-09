module.exports = (sql, SQL) => sql.define('classExercise', {
  id: { type: SQL.INTEGER, autoIncrement: true, primaryKey: true },
  index: { type: SQL.INTEGER },
  classId: { type: SQL.INTEGER },
  movementId: { type: SQL.INTEGER },
  notes: { type: SQL.TEXT },
  duration: { type: SQL.INTEGER, defaultValue: 1 },
  repetitions: { type: SQL.INTEGER, defaultValue: 1 },
});