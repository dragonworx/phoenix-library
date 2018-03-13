const webpack = require('webpack');
const path = require('path');

module.exports = (entryFile, outputFile) => ({
  devtool: 'source-map',
  entry: path.resolve(__dirname, entryFile),
  output: {
    path: path.resolve(__dirname, 'static'),
    publicPath: '/',
    filename: outputFile
  },
  module: {
    loaders: [
      { test: /\.css$/, include: path.resolve(__dirname, 'client'), loader: 'style-loader!css-loader' },
      { test: /\.js[x]?$/, include: path.resolve(__dirname, 'client'), exclude: /node_modules/, loader: 'babel-loader' }
    ]
  },
  resolve: {
    extensions: ['.js', '.jsx']
  }
});