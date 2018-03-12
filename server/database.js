const Sequelize = require('sequelize');
const Op = Sequelize.Op;

const PHOENIX_DB = process.env.PHOENIX_DB;
const PHOENIX_USER = process.env.PHOENIX_USER;
const PHOENIX_PASSWORD = process.env.PHOENIX_PASSWORD;

if (!(PHOENIX_DB && PHOENIX_USER && PHOENIX_PASSWORD)) {
  console.error('Cannot read environment db variables');
  process.exit(-1);
}

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