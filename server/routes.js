const log = require('./log');
const api = require('./api');

function encodedUser (req) {
  const sessionUser = req.session.user;
    return Buffer.from(JSON.stringify(sessionUser)).toString('base64');
}

module.exports = function (app) {
  /* get */

  app.use((req, res, next) => {
    res.sendJSON = data => {
      res.setHeader('Content-Type', 'application/json');
      res.setHeader('Accept-Ranges', 'bytes');
      res.setHeader('Cache-Control', 'no-cache');
      res.send(JSON.stringify(data));
    };
    res.send500 = error => {
      res.setHeader('Content-Type', 'text/plain');
      res.status(500);
      res.send(JSON.stringify((error && error.stack) || String(error)));
    };
    next();
  });

  app.get('/ping', async (req, res) => {
    const onReject = error => {
      res.send500(error);
    };
    try {
      await api.ping();
      res.end();
      return;
    } catch (error) {
      onReject(error);
    }
    if (!req.session || (!req.session.user)) {
      onReject('No session');
    }
    res.end();
  });

  app.get('/login', (req, res) => {
    const user = req.session.user;
    if (user) {
      res.redirect(user.isAdmin ? '/admin/land' : '/');
    } else {
      res.render('login');
    }
  });

  // Debugging...
  app.get('/photo/:env/:exerciseId', (req, res) => {
    const { env, exerciseId } = req.params;
    res.render('photo', { env, exerciseId });
  });
  
  /* authenticate */

  app.use((req, res, next) => {  
    const user = req.session.user;
    const isAdmin = !!(user && user.isAdmin);
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
    res.redirect('/admin/');
  });

  app.get('/', (req, res) => {
    res.render('index');
  });
  
  app.get('/logout', (req, res) => {
    delete req.session.user;
    res.redirect('/login');
  });

  app.get('/exercise/get', async (req, res) => {
    const data = await api.getExercises();
    res.sendJSON(data);
  });

  /* post */

  app.post('/login', async (req, res) => {
    const user = await api.login(req.body.email, req.body.password);
    if (user) {
      log('user found: ' + JSON.stringify(user), 'green');
      req.session.user = user;
    } else {
      log('user not found', 'red');
      res.status(401);
    }
    res.end();
  });

  app.put('/exercise/photo', async (req, res) => {
    const exerciseId = parseInt(req.body.exerciseId, 10);
    const image = req.files && req.files.photo;
    try {
      await api.uploadPhoto(exerciseId, image);
      res.sendJSON({
        id: exerciseId,
        photo: image && image.name,
      });
    } catch (error) {
      res.send500(error);
    }
  });

  app.post('/exercise/add', async (req, res) => {
    const name = req.body.name;
    const springs = req.body.springs;
    const description = req.body.description;
    const photo = req.files && req.files.photo;
    const video = req.body.video;
    const usage = JSON.parse(req.body.usage);
    try {
      const exerciseId = await api.addExercise(
        name,
        springs,
        description,
        photo,
        video,
        usage,
      );
      res.sendJSON({
        id: exerciseId,
        photo: photo && photo.name,
      });
    } catch (error) {
      res.send500(error);
    }
  });

  app.post('/exercise/edit', async (req, res) => {
    const exerciseId = parseInt(req.body.id, 10);
    const name = req.body.name;
    const springs = req.body.springs;
    const description = req.body.description;
    const photo = req.files && req.files.photo;
    const video = req.body.video;
    const usage = JSON.parse(req.body.usage);
    try {
      await api.editExercise(
        exerciseId,
        name,
        springs,
        description,
        photo,
        video,
        usage,
      );
      res.sendJSON({
        id: exerciseId,
        photo: photo && photo.name,
      });
    } catch (error) {
      res.send500(error);
    }
  });

  app.post('/exercise/delete', async (req, res) => {
    const ids = req.body.ids;
    try {
      await api.deleteExercises(ids);
      res.end();
    } catch (error) {
      res.send500(error);
    }
  });
};