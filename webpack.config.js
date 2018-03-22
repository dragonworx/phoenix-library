const webpack = require('webpack');
const path = require('path');
const WebpackBuildNotifierPlugin = require('webpack-build-notifier');
const uglifyJsPlugin = webpack.optimize.UglifyJsPlugin;
const log = require('./server/log');

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
    extensions: ['.js', '.jsx']
  },
});

const devConfig = (entry, outfile) => {
  log('devConfig: ' + entry);
  return {
    ...defaultConfig(entry, outfile),
    plugins: [
      new WebpackBuildNotifierPlugin({
        title: "Phoenix Library"
      })
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
    ]
  };
};
prodConfig.envName = 'prod';

const config = process.env.PHOENIX_LIB_ENV === 'dev' ? devConfig : prodConfig;
log('Building ' + config.envName, 'green');

module.exports = [
  /* /login */
  config('client/login/_main.js', './login-bundle.js'),
  /* /admin */
  config('client/admin/_main.js', './admin-bundle.js'),
];
