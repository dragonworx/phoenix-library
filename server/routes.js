const log = require('./log');
const api = require('./api');
const readPermissions = require('../common/permissions')
const PrintedClass = require('./printed');

function encodedUser (req) {
  const sessionUser = req.session.user;
  return sessionUser ? Buffer.from(JSON.stringify(sessionUser)).toString('base64') : undefined;
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
      res.redirect(readPermissions(user.permissions).isAdmin ? '/admin/land' : '/');
    } else {
      res.render('login');
    }
  });

  // Debugging...
  app.get('/photo/:env/:exerciseId', (req, res) => {
    const { env, exerciseId } = req.params;
    res.render('photo', { env, exerciseId });
  });

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
  
  /* authenticated */

  app.use((req, res, next) => {  
    const user = req.session.user;
    const isAdmin = !!(user && readPermissions(user.permissions).isAdmin);
    const isUnauthorised = (req.url.match('^\/admin') && !isAdmin) || !user
      || (req.url === '/' && !user);
    const isAssetUrl = !!req.url.match(/\.[a-z]+$/);
  
    log(req.url, isUnauthorised ? 'red' : 'green');
  
    if (isUnauthorised && !isAssetUrl) {
      return res.redirect('/login?next=' + req.url);
    }
  
    next();
  });

  app.get('/admin', (req, res) => {
    res.render('admin', { user: encodedUser(req) });
  });

  app.get('/admin/exercises', (req, res) => {
    res.render('admin', { user: encodedUser(req) });
  });

  app.get('/admin/classes', (req, res) => {
    res.render('admin', { user: encodedUser(req) });
  });

  app.get('/admin/land', (req, res) => {
    res.redirect('/admin/classes');
  });

  app.get('/', (req, res) => {
    res.render('index', { user: encodedUser(req) });
  });

  app.get('/exercises', (req, res) => {
    res.render('index', { user: encodedUser(req) });
  });

  app.get('/classes', (req, res) => {
    res.render('index', { user: encodedUser(req) });
  });

  app.get('/class/program/:classId', async (req, res) => {
    const classId = parseInt(req.params.classId, 10);
    const program = await api.getClassProgram(classId);
    res.sendJSON(program);
  });
  
  app.get('/logout', (req, res) => {
    delete req.session.user;
    res.redirect('/login');
  });

  app.get('/exercise/get', async (req, res) => {
    const data = await api.getExercises();
    res.sendJSON(data);
  });

  app.get('/labels/get', async (req, res) => {
    const labels = await api.getAllLabels();
    res.sendJSON(labels);
  });

  app.get('/counts', async (req, res) => {
    const data = await api.getCounts();
    res.sendJSON(data);
  });

  app.get('/classes/get', async (req, res) => {
    const data = await api.getClasses();
    res.sendJSON(data);
  });

  app.get('/template/:genreId', async (req, res) => {
    const { genreId } = req.params;
    const data = await api.getTemplate(genreId);
    res.sendJSON(data);
  });

  app.get('/label/get/:type', async (req, res) => {
    const data = await api.getLabels(req.params.type);
    res.sendJSON(data);
  });

  app.get('/class/category/exercises/:genreId/:movementId', async (req, res) => {
    const genreId = parseInt(req.params.genreId, 10);
    const movementId = parseInt(req.params.movementId, 10);
    const data = await api.getClassCategoryExercises(genreId, movementId);
    res.sendJSON(data);
  });

  app.post('/exercise/usage', async (req, res) => {
    // decorate the given exercise with usage, genre, movementId...get ready class usage
    const exercise = req.body.exercise;
    await api.getExerciseUsage(exercise);
    res.sendJSON(exercise);
  });

  app.get('/class/categories/:genreId', async (req, res) => {
    const genreId = parseInt(req.params.genreId, 10);
    const data = await api.getClassCategories(genreId);
    res.sendJSON(data);
  });

  app.post('/class/add', async (req, res) => {
    const cls = req.body;
    const details = await api.addClass(cls);
    res.sendJSON(details);
  });

  app.post('/class/edit', async (req, res) => {
    const cls = req.body;
    const details = await api.editClass(cls);
    res.sendJSON(details);
  });

  // function createRoute(url, handler) {
  //   const params = handler
  //     .toString()
  //     .match(/\(([^)]*)\)[ =>]*{/)[1]
  //     .split(',')
  //     .map(x => x.trim());
  // }

  /* post */
  
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
      const revision = await api.editExercise(
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
        revision,
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

  app.post('/class/delete', async (req, res) => {
    const ids = req.body.ids;
    try {
      await api.deleteClasses(ids);
      res.end();
    } catch (error) {
      res.send500(error);
    }
  });

  app.get('/class/:classId', async (req, res) => {
    const id = parseInt(req.params.classId, 10);
    const cls = await api.getClass(id);

    res.setHeader('Content-Type', 'application/pdf');
    res.setHeader('Accept-Ranges', 'bytes');
    res.setHeader('Cache-Control', 'no-cache');

    const printed = new PrintedClass(cls);
    const doc = printed.doc;

    // send to http response
    doc.pipe(res);

    // Finalize PDF file
    doc.end();
  });
};