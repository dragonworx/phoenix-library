module.exports = (sql, SQL) => sql.define('user', {
  id: { type: SQL.INTEGER, autoIncrement: true, primaryKey: true },
  firstName: { type: SQL.TEXT },
  lastName: { type: SQL.TEXT },
  email: { type: SQL.TEXT },
  password: { type: SQL.TEXT },
  permissions: { type: SQL.TEXT },
  lastLogin: { type: SQL.DATE },
});

/*
permissions:
  exercises: 0/1
  classes: 0/1
  users: 0/1
*/