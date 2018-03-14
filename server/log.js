const clc = require('cli-color');

module.exports = function log(obj, color = 'blue') {
  console.log(clc[color].bold(JSON.stringify(obj).replace(/^\{|\}$/g, '')));
};