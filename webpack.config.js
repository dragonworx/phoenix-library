const WebpackBuildNotifierPlugin = require('webpack-build-notifier');
const defaultConfig = require('./webpack.defaults');

const config = (entry, outfile) => {
  return {
    ...defaultConfig(entry, outfile),
    plugins: [
      new WebpackBuildNotifierPlugin({
        title: "Phoenix Library"
      })
    ]
  };
};

module.exports = [
  /* /login */
  config('client/login/_main.js', './login-bundle.js'),
  /* /admin */
  config('client/admin/_main.js', './admin-bundle.js'),
];
