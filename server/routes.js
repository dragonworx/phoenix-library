const log = require('./log');

module.exports = function (app) {
  app.get('/login', (req, res) => {
    const user = !!req.session.user;
    if (user) {
      res.redirect(user.admin ? '/admin' : '/');
    } else {
      res.render('login');
    }
  });
  
  app.post('/login', (req, res) => {
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
  
  app.get('/', function (req, res) {
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
  
  app.get('/logout', function (req, res) {
    delete req.session.authenticated;
    res.redirect('/login');
  });
};