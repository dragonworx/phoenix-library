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

  app.use((req, res, next) => {
    res.sendJSON = data => {
      res.setHeader('Content-Type', 'application/json');
      res.send(JSON.stringify(data));
    };
    next();
  });

  app.get('/login', (req, res) => {
    const user = req.session.user;
    if (user) {
      res.redirect(user.is_admin ? '/admin/land' : '/');
    } else {
      res.render('login');
    }
  });
  
  /* authenticate */

  app.use( (req, res, next) => {  
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

  app.get('/admin', (req, res) => {
    res.render('admin', { user: encodedUser(req) });
  });

  app.get('/admin/land', (req, res) => {
    res.redirect('/admin/exercises');
  });

  app.get('/admin/users', (req, res) => {
    res.render('admin', { user: encodedUser(req) });
  });

  app.get('/admin/exercises', (req, res) => {
    res.render('admin', { user: encodedUser(req) });
  });

  app.get('/', (req, res) => {
    res.render('index');
  });
  
  app.get('/logout', (req, res) => {
    delete req.session.user;
    res.redirect('/login');
  });

  app.get('/exercise/get', (req, res) => {
    api.getExercises()
      .then(array => {
        res.sendJSON(array);
      });
  });

  /* post */

  app.post('/login', (req, res) => {
    api.login(req.body.email, req.body.password)
      .then(user => {
        if (user) {
          req.session.user = user;
          res.end();
        } else {
          res.status(401);
          res.end();
        }
      });
  });

  app.post('/exercise/add', (req, res) => {
    const name = req.body.name;
    const springs = req.body.springs;
    const description = req.body.description;
    const photo = req.files && req.files.photo;
    const video = req.body.video;
    api.addExercise(
      name,
      springs,
      description,
      photo,
      video
    ).then(id => {
      res.sendJSON({ id });
    }).catch(error => {
      res.status(500);
      res.sendJSON({ error });
    });
  });

  app.post('/exercise/delete', (req, res) => {
    const ids = req.body.ids;
    api.deleteExercises(ids)
      .then(() => {
        res.end();
      })
      .catch(error => {
        res.status(500);
        res.sendJSON({ error });
      });
  });

  app.post('/exercise/edit', (req, res) => {
    const id = req.body.id;
    const name = req.body.name;
    const springs = req.body.springs;
    const description = req.body.description;
    const photo = req.files && req.files.photo;
    const video = req.body.video;
    api.editExercise(
      id,
      name,
      springs,
      description,
      photo,
      video
    ).then(() => {
      res.end();
    }).catch(error => {
      res.status(500);
      res.sendJSON({ error });
    });
  });
};