const log = require('./log');
const api = require('./api');

function encodedUser (req) {
  const sessionUser = req.session.user;
    const user = {
      first_name: sessionUser.first_name,
      last_name: sessionUser.first_name,
      is_designer: sessionUser.is_designer,
      is_super: sessionUser.is_super
    };
    return Buffer.from(JSON.stringify(user)).toString('base64');
}

module.exports = function (app) {
  /* get */

  app.get('/login', (req, res) => {
    const user = req.session.user;
    if (user) {
      res.redirect(user.is_admin ? '/admin' : '/');
    } else {
      res.render('login');
    }
  });
  
  /* authenticate */

  app.use(function authenticate (req, res, next) {  
    const user = req.session.user;
    const isAdmin = !!(user && user.is_admin);
    const isUnauthorised = (req.url.match('^\/admin') && !isAdmin)
      || (req.url === '/' && !user);
    const isAssetUrl = !!req.url.match(/\.[a-z]+$/);
  
    log({
      authenticate: req.url,
      user,
    }, isUnauthorised ? 'red' : 'green');
  
    if (isUnauthorised && !isAssetUrl) {
      return res.redirect('/login');
    }
  
    next();
  });

  app.get('/admin', function (req, res) {
    res.render('admin', { user: encodedUser(req) });
  });

  app.get('/admin/users', function (req, res) {
    res.render('admin', { user: encodedUser(req) });
  });

  app.get('/admin/exercises', function (req, res) {
    res.render('admin', { user: encodedUser(req) });
  });

  app.get('/', function (req, res) {
    res.render('index');
  });
  
  app.get('/logout', function (req, res) {
    delete req.session.user;
    res.redirect('/login');
  });

  /* post */

  app.post('/login', (req, res) => {
    api.login(req.body.email, req.body.password).then(user => {
      if (user) {
        req.session.user = user;
        res.end();
      } else {
        res.status(401);
        res.end();
      }
    });
  });
};