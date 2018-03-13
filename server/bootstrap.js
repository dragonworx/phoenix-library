const path = require('path');
const express = require('express');
const logger = require('morgan');
const bodyParser = require('body-parser');
const favicon = require('serve-favicon');
const session = require('express-session');
const sql = require('./database');
const clc = require('cli-color');

process.on('unhandledRejection', function(err) {
  console.error(err.stack);
  process.exit(-1);
});

function log(obj, color = 'blue') {
  console.log(clc[color].bold(JSON.stringify(obj).replace(/^\{|\}$/g, '')));
}

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

app.get('/login', (req, res, next) => {
  const user = !!req.session.user;
  if (user) {
    res.redirect(user.admin ? '/admin' : '/');
  } else {
    res.render('login');
  }
});

app.post('/login', (req, res, next) => {
  res.send(JSON.stringify({un: req.body.email, pw: req.body.password})).end();
});

app.use(function authenticate (req, res, next) {  
  const user = req.session.user;
  const isAdmin = !!(user && user.admin);
  const isUnauthorised = (req.url === '/admin' && !isAdmin)
    || (req.url === '/' && !user);
  const isAssetUrl = !!req.url.match(/\.[a-z]+$/);

  log({
    authenticate: req.url,
    user,
    isAdmin,
    isUnauthorised,
    isAssetUrl,
  });

  if (isUnauthorised && !isAssetUrl) {
    return res.redirect('/login');
  }

  next();
});

app.get('/', function (req, res, next) {
  res.render('index');
});

// app.post('/login', function (req, res, next) {

// 	// you might like to do a database look-up or something more scalable here
// 	if (req.body.username && req.body.username === 'user' && req.body.password && req.body.password === 'pass') {
// 		req.session.authenticated = true;
// 		res.redirect('/secure');
// 	} else {
// 		req.flash('error', 'Username and password are incorrect');
// 		res.redirect('/login');
// 	}

// });

app.get('/logout', function (req, res, next) {
	delete req.session.authenticated;
	res.redirect('/login');
});
  
app.use(function(req, res, next) {
  const isAssetUrl = !!req.url.match(/\.[a-z]+$/);
  if (isAssetUrl) {
    res.status(404).end();
  } else {
    res.render('error', {url: req.url, status: 404});
  }
});


app.listen(3000);
console.log(clc.green.bold('server started on port 3000'));

module.exports = new Promise((resolve, reject) => {
  sql.authenticate()
    .then(resolve)
    .catch(reject);
});