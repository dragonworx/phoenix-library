const path = require('path');
const express = require('express');
const logger = require('morgan');
const bodyParser = require('body-parser');
const favicon = require('serve-favicon');
const session = require('express-session');
const sql = require('./database');
const routes = require('./routes');
const log = require('./log');

process.on('unhandledRejection', function (err) {
  console.error(err.stack);
  process.exit(-1);
});

const app = express();

app.set('view engine', 'ejs');
app.use(session({
  secret: 'foobar',
  cookie: {},
  resave: false,
  saveUninitialized: false,
}));
app.use(favicon(path.join(__dirname, 'favicon.ico')));
app.use(logger('dev'));
app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: false }));

app.use(express.static(path.resolve(__dirname, '../static')));

routes(app);
  
app.use(function(req, res) {
  const isAssetUrl = !!req.url.match(/\.[a-z]+$/);
  if (isAssetUrl) {
    res.status(404).end();
  } else {
    res.render('error', {url: req.url, status: 404});
  }
});


app.listen(3000);

log('server started on port 3000', 'green');

module.exports = new Promise((resolve, reject) => {
  sql.authenticate()
    .then(resolve)
    .catch(reject);
});