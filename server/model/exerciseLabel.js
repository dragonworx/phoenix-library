module.exports = (sql, SQL) => {
  const ExerciseLabels = sql.define('exerciseLabel', {
    id: { type: SQL.INTEGER, autoIncrement: true, primaryKey: true },
    exerciseId: { type: SQL.INTEGER },
    genreId: { type: SQL.INTEGER },
    movementId: { type: SQL.INTEGER },
  });
  return ExerciseLabels;
};