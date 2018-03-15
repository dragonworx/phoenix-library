const password = require('../server/password');
const clc = require('cli-color');

const text = process.argv[2];
console.log(clc.green.bold('hashing: ' + text));

password.hash(text).then(hash => {
  password.verify(text, hash).then(verified => {
    if (verified) {
      console.log(clc.cyan.bold(hash));
    } else {
      console.log(clc.red.bold('Failed to verify without error?'));
    }
  }).catch(err => console.error(clc.red.bold('Failed to verify : ' + err)));
}).catch(err => console.error(clc.red.bold('Failed to hash: ' + err)));