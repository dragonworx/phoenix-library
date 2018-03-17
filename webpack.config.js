const config = require('./webpack.defaults');

module.exports = [
  {
    /* /login */
    ...config('client/login/_main.js', './login-bundle.js'),
  },
  {
    /* /admin */
    ...config('client/admin/_main.js', './admin-bundle.js'),
  },
];
