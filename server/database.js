const Sequelize = require('sequelize');
const Op = Sequelize.Op;
const env = require('./environment');
const log = require('./log');
const models = require('./models');

process.on('unhandledRejection', function (err) {
  log(err.stack ? err.stack : err, 'red');
  process.exit(-1);
});

const { PHOENIX_DB, PHOENIX_USER, PHOENIX_PASSWORD } = env(['PHOENIX_DB', 'PHOENIX_USER', 'PHOENIX_PASSWORD']);

const sql = new Sequelize(
  PHOENIX_DB,
  PHOENIX_USER,
  PHOENIX_PASSWORD,
  {
    host: '127.0.0.1',
    dialect: 'postgres',
    logging: false,
    freezeTableName: true,
    operatorsAliases: {
      $and: Op.and,
      $or: Op.or,
      $eq: Op.eq,
      $gt: Op.gt,
      $lt: Op.lt,
      $lte: Op.lte,
      $like: Op.like
    }
  }
);

module.exports = new Promise((resolve, reject) => {
  sql.authenticate()
  .then(() => {
    log(`Database connection esablished successfully: ${PHOENIX_USER}@${PHOENIX_DB}`, 'green');
    log('Registering Models');
    models.load(sql, Sequelize, { force: false })
      .then(() => {
        log('Database ready', 'green');
        resolve(sql);
      });
  })
  .catch(err => {
    log('Database connection failed: ' + err, 'red');
    reject(err);
  });
});