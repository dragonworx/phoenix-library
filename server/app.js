const express = require('express');
const logger = require('morgan');
const bodyParser = require('body-parser');
const indexRoute = require('./routes/index');
const passport = require('passport');
const CustomStrategy = require('passport-custom');

process.on('unhandledRejection', function(err) {
  console.error(err.stack);
  process.exit(-1);
});

passport.serializeUser(function(user, done) {
  done(null, user);
});

passport.deserializeUser(function(user, done) {
  done(null, user);
});

passport.use('custom', new CustomStrategy(
  function(req, done) {
    // User.findOne({
    //   username: req.body.username
    // }, function (err, user) {
    //   done(err, user);
    // });
    done(null, req.body.username === 'admin' ? {admin:true} : false);
  }
));

const app = express();

app.use(logger('dev'));
app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: false }));
app.use(passport.initialize());
app.use(passport.session());
app.use('/',
  passport.authenticate('custom'),
  indexRoute
);

// catch 404 and forward to error handler
app.use(function(req, res, next) {
 let err = new Error('404 Not Found: ' + req.url);
 err.status = 404;
 next(err);
});

app.use(function(err, req, res, next) {
  res.status(err.status || 500);
  res.send(err.status === 404 ? err.message : err.stack);
});

app.listen(3000);
console.log('server:3000');

module.exports = app;