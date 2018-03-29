module.exports = (sql, SQL) => sql.define('user', {
  id: { type: SQL.INTEGER, autoIncrement: true, primaryKey: true },
  firstName: { type: SQL.TEXT },
  lastName: { type: SQL.TEXT },
  email: { type: SQL.TEXT },
  password: { type: SQL.TEXT },
  isSuper: { type: SQL.BOOLEAN },
  isAdmin: { type: SQL.BOOLEAN },
  isDesigner: { type: SQL.BOOLEAN },
  lastLogin: { type: SQL.DATE },
});