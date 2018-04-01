const webpack = require('webpack');
const path = require('path');
const WebpackBuildNotifierPlugin = require('webpack-build-notifier');
const uglifyJsPlugin = webpack.optimize.UglifyJsPlugin;
const log = require('./server/log');
const pkg = require('./package.json');
const PHOENIX_LIB_VERSION = pkg.version;
const PHOENIX_LIB_STORAGE = 'https://masstorage.sgp1.digitaloceanspaces.com/';

log(`phoenix_lib v${PHOENIX_LIB_VERSION}`, 'cyan');

const defaultConfig = (entryFile, outputFile) => ({
  devtool: 'source-map',
  entry: [/*'babel-polyfill', */path.resolve(__dirname, entryFile)],
  output: {
    path: path.resolve(__dirname, 'static'),
    publicPath: '/',
    filename: outputFile
  },
  module: {
    loaders: [
      { test: /\.css$/, include: [
        path.resolve(__dirname, 'client')
      ], loader: 'style-loader!css-loader' },
      { test: /\.js[x]?$/, include: path.resolve(__dirname, 'client'), exclude: /node_modules/, loader: 'babel-loader' }
    ]
  },
  resolve: {
    extensions: ['.js', '.jsx'],
    alias: {
      // server: path.resolve(__dirname, 'server'),
    },
  },
});

const devConfig = (entry, outfile) => {
  log('devConfig: ' + entry);
  return {
    ...defaultConfig(entry, outfile),
    plugins: [
      new WebpackBuildNotifierPlugin({
        title: "Phoenix Library"
      }),
      new webpack.DefinePlugin({
        PHOENIX_LIB_ENV: JSON.stringify('dev'),
        PHOENIX_LIB_STORAGE: JSON.stringify(PHOENIX_LIB_STORAGE + 'phoenix_lib/dev/excelsior/'),
        PHOENIX_LIB_VERSION: JSON.stringify(PHOENIX_LIB_VERSION),
      }),
    ]
  };
};
devConfig.envName = 'dev';

const prodConfig = (entry, outfile) => {
  log('prodConfig: ' + entry);
  return {
    ...defaultConfig(entry, outfile),
    plugins: [
      new uglifyJsPlugin({
        compress: {
          warnings: false
        }
      }),
      new webpack.DefinePlugin({
        PHOENIX_LIB_ENV: JSON.stringify('prod'),
        PHOENIX_LIB_STORAGE: JSON.stringify(PHOENIX_LIB_STORAGE + 'phoenix_lib/prod/excelsior/'),
        PHOENIX_LIB_VERSION: JSON.stringify(PHOENIX_LIB_VERSION),
      }),
    ]
  };
};
prodConfig.envName = 'prod';

const config = process.env.PHOENIX_LIB_ENV === 'dev' ? devConfig : prodConfig;
log('Building ' + config.envName, 'green');

module.exports = [
  /* /login */
  config('client/main_login.js', './login-bundle.js'),
  /* /admin */
  config('client/main_admin.js', './admin-bundle.js'),
  /* /index */
  config('client/main_index.js', './index-bundle.js'),
];
