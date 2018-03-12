const path = require('path');
const express = require('express');
const logger = require('morgan');
const bodyParser = require('body-parser');
const favicon = require('serve-favicon');
const authentication = require('./authentication');
const sql = require('./database');
// const indexRoute = require('./routes/index');

process.on('unhandledRejection', function(err) {
  console.error(err.stack);
  process.exit(-1);
});

const app = express();

app.use(favicon(path.join(__dirname, 'favicon.ico')));
app.use(logger('dev'));
app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: false }));

const authenticate = authentication(app);

app.get('/',
  function (req, res, next) {
    if (!req.user) {
      res.redirect('/login.html');
    } else {
      next();
    }
  },
  authenticate(),
);

app.use(express.static(path.resolve(__dirname, '../public')));

// catch 404 and forward to error handler
app.use(function(req, res, next) {
 let err = new Error('404 Not Found: ' + req.url);
 err.status = 404;
 next(err);
});

app.use(function(err, req, res, next) {
  res.status(err.status || 500);
  if (err.status === 404) {
    res.redirect('/404.html');
  } else {
    res.send(err.stack);
  }
});

app.listen(3000);
console.log('server started on port 3000');

module.exports = new Promise((resolve, reject) => {
  sql.authenticate()
    .then(resolve)
    .catch(reject);
});