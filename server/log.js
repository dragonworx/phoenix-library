const clc = require('cli-color');

module.exports = function log(obj, color = 'blue') {
  const output = typeof obj === 'object'
    ? JSON.stringify(obj, null, 4)
    : '' + obj;
  console.log(clc[color].bold(output));
};