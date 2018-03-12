const passport = require('passport');
const CustomStrategy = require('passport-custom');

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
    // done(null, req.body.username === 'admin' ? {admin:true} : false);

    done(null, {});
    // done(false);
  }
));

module.exports = app => {
  app.use(passport.initialize());
  app.use(passport.session());
  return (successRedirect) => passport.authenticate('custom', {
    // successRedirect: successRedirect,
    failureRedirect: '/login.html'
  });
};