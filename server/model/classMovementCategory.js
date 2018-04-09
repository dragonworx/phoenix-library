module.exports = (sql, SQL) => sql.define('classMovementCategory', {
  id: { type: SQL.INTEGER, autoIncrement: true, primaryKey: true },
  index: { type: SQL.INTEGER },
  classId: { type: SQL.INTEGER },
  labelId: { type: SQL.INTEGER },
});