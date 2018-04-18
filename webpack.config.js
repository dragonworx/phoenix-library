const webpack = require('webpack');
const path = require('path');
const WebpackBuildNotifierPlugin = require('webpack-build-notifier');
const HardSourceWebpackPlugin = require('hard-source-webpack-plugin');
const CleanWebpackPlugin = require('clean-webpack-plugin');
const WebpackPreBuildPlugin = require('pre-build-webpack');
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
    path: path.resolve(__dirname, 'static', 'dist'),
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
    // NOTE: alias's need to be found by eslint (how?), otherwise they cause exceptions
    // alias: {
    //   client: path.resolve(__dirname, 'client'),
    //   member: path.resolve(__dirname, 'client/member'),
    // },
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
      new HardSourceWebpackPlugin(),
      new WebpackPreBuildPlugin((/*stats*/) => {
        log(`${PHOENIX_LIB_VERSION} Build started @ ` + (new Date().toLocaleTimeString()) + ' ...', 'green');
      }),
      new CleanWebpackPlugin(['static/dist/*.js', 'static/dist/*.map']),
    ]
  };
};
devConfig.envName = 'dev';

const prodConfig = (entry, outfile) => {
  log('prodConfig: ' + entry);
  return {
    ...defaultConfig(entry, outfile),
    plugins: [
      /*new uglifyJsPlugin({
        compress: {
          warnings: false
        }
      }),*/
      new webpack.DefinePlugin({
        PHOENIX_LIB_ENV: JSON.stringify('prod'),
        PHOENIX_LIB_STORAGE: JSON.stringify(PHOENIX_LIB_STORAGE + 'phoenix_lib/prod/excelsior/'),
        PHOENIX_LIB_VERSION: JSON.stringify(PHOENIX_LIB_VERSION),
      }),
      new WebpackPreBuildPlugin((/*stats*/) => {
        log(`${PHOENIX_LIB_VERSION} Build started @ ` + (new Date().toLocaleTimeString()) + ' ...', 'green');
      }),
      new CleanWebpackPlugin(['static/dist/*.js', 'static/dist/*.map']),
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
