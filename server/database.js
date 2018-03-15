const Sequelize = require('sequelize');
const Op = Sequelize.Op;
const env = require('./environment');
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

module.exports = sql;