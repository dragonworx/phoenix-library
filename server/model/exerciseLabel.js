module.exports = (sql, SQL) => 
  sql.define('exercise_label', {
    id: { type: SQL.INTEGER, autoIncrement: true, primaryKey: true },
    exerciseId: { type: SQL.INTEGER },
    genreId: { type: SQL.INTEGER },
    movementId: { type: SQL.INTEGER },
  });