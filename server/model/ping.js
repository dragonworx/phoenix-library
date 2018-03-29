module.exports = (sql, SQL) => sql.define('ping', {
  lastPing: { type: SQL.DATE },
}, {
  freezeTableName: true,
  timestamps: false,
});