const fs = require('fs');
const path = require('path');

const requiredEnvVars = [
  'PHOENIX_DB',
  'PHOENIX_USER',
  'PHOENIX_PASSWORD',
  'PHOENIX_ENV',
  'MASSTORAGE_KEY_ID',
  'MASSTORAGE_SECRET'
];

const outputFilePath = path.join(__dirname, 'vars.txt');
const output = requiredEnvVars.map((envVar) => {
  if (process.env[envVar]) {
    return `${envVar}: ${process.env[envVar]}`;
  } else {
    return `${envVar} is not set`;
  }
}).join('\n');

fs.writeFileSync(outputFilePath, output, 'utf8');
