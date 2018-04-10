module.exports = (sql, SQL) => sql.define('classExercise', {
  id: { type: SQL.INTEGER, autoIncrement: true, primaryKey: true },
  exerciseId: { type: SQL.INTEGER },
  index: { type: SQL.INTEGER },
  classMovementCategoryId: { type: SQL.INTEGER },
  notes: { type: SQL.TEXT },
  duration: { type: SQL.INTEGER, defaultValue: 1 },
  repetitions: { type: SQL.INTEGER, defaultValue: 1 },
});