const path = require('path');
const express = require('express');
const logger = require('morgan');
const bodyParser = require('body-parser');
const favicon = require('serve-favicon');
const session = require('express-session');
const database = require('./database');
const routes = require('./routes');
const log = require('./log');
const env = require('./environment');
const { PHOENIX_PASSWORD } = env(['PHOENIX_PASSWORD']);

database.then(() => {
  const app = express();

  app.set('view engine', 'ejs');
  app.use(session({
    secret: PHOENIX_PASSWORD,
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
}).catch(err => {
  log('server failed to start: ' + err, 'red');
  process.exit(-1);
});