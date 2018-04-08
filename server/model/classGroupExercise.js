module.exports = (sql, SQL) => sql.define('classGroupExercise', {
  id: { type: SQL.INTEGER, autoIncrement: true, primaryKey: true },
  index: { type: SQL.INTEGER },
  classId: { type: SQL.INTEGER },
  groupId: { type: SQL.INTEGER },
  notes: { type: SQL.TEXT },
  duration: { type: SQL.INTEGER, defaultValue: 1 },
  repetitions: { type: SQL.INTEGER, defaultValue: 1 },
});