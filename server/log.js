const clc = require('cli-color');
const fs = require('fs');
const path = require('path');

const logFile = path.resolve(__dirname, '../log.txt');

module.exports = function log(obj, color = 'blue') {
  const output = typeof obj === 'object'
    ? JSON.stringify(obj, null, 4)
    : '' + obj;
    if (!fs.existsSync(logFile)) {
      fs.writeFileSync(logFile, '');
    }
    fs.appendFileSync(logFile, output + '\n');
  console.log(clc[color].bold(output));
};