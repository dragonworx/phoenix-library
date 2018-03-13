const path = require('path');
const express = require('express');
const logger = require('morgan');
const bodyParser = require('body-parser');
const favicon = require('serve-favicon');
const session = require('express-session');
// const authentication = require('./authentication');
const sql = require('./database');
// const indexRoute = require('./routes/index');

process.on('unhandledRejection', function(err) {
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

// const authenticate = authentication(app);

// app.get('/',
//   function (req, res, next) {
//     if (!req.user) {
//       res.redirect('/login.html');
//     } else {
//       next();
//     }
//   },
//   authenticate(),
// );

app.use(express.static(path.resolve(__dirname, '../static')));



function checkAuth (req, res, next) {
	console.log('checkAuth ' + req.url);

	// don't serve /secure to those not logged in
	// you should add to this list, for each and every secure url
	if (req.url === '/admin' && (!req.session || !req.session.authenticated)) {
		res.render('login', { status: 403 });
		return;
	}

	next();
}

	app.use(checkAuth);
 
  app.get('/', function (req, res, next) {
		res.render('index');
  });
  
  app.get('/login', function (req, res, next) {
		res.render('login');
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

	// app.get('/logout', function (req, res, next) {
	// 	delete req.session.authenticated;
	// 	res.redirect('/');
	// });
  
  // catch 404 and forward to error handler
  app.use(function(req, res, next) {
    let err = new Error('404 Not Found: ' + req.url);
    err.status = 404;
    next(err);
    res.render('error', {status: 400});
  });

  // app.use(function(err, req, res, next) {
  //   res.status(err.status || 500);
  //   if (err.status === 404) {
  //     res.render('/404');
  //   } else {
  //     res.send(err.stack);
  //   }
  // });


app.listen(3000);
console.log('server started on port 3000');

module.exports = new Promise((resolve, reject) => {
  sql.authenticate()
    .then(resolve)
    .catch(reject);
});