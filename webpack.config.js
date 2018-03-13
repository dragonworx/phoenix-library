const config = require('./webpack.defaults');

module.exports = [
  {
    ...config('client/login/_main.js', './login-bundle.js')
  }
];
