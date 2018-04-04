const path = require('path');
const express = require('express');
const logger = require('morgan');
const bodyParser = require('body-parser');
const favicon = require('serve-favicon');
const session = require('express-session');
const fileUpload = require('express-fileupload');
const database = require('./database');
const routes = require('./routes');
const log = require('./log');
const env = require('./environment');
const { PHOENIX_PASSWORD } = env(['PHOENIX_PASSWORD']);

log('Starting phoenix_lib server...', 'cyan');

database.then(() => {
  log('Database ready', 'green');
  const app = express();

  app.set('view engine', 'ejs');
  app.use(session({
    secret: PHOENIX_PASSWORD,
    cookie: {
      maxAge: 1000 * 60 * 60 * 24 /* 1 day */
    },
    resave: false,
    saveUninitialized: false,
  }));
  app.use(favicon(path.resolve(__dirname, '../static/favicon.ico')));
  app.use(logger('dev'));
  app.use(bodyParser.json());
  app.use(bodyParser.urlencoded({ extended: false }));

  app.use(express.static(path.resolve(__dirname, '../static')));

  app.use(fileUpload());

  routes(app);
    
  app.use(function(req, res) {
    const isAssetUrl = !!req.url.match(/\.[a-z]+$/);
    if (isAssetUrl) {
      res.status(404).end();
    } else {
      res.status(404);
      res.render('error', {url: req.url, status: 404});
    }
  });

  app.listen(3000);
  log('server started on port 3000', 'green');
}).catch(err => {
  log('server failed to start: ' + err, 'red');
  process.exit(-1);
});