const password = require('../server/password');
const log = require('../server/log');

const text = process.argv[2];
log('hashing: ' + text, 'green');

password.hash(text).then(hash => {
  password.verify(text, hash).then(verified => {
    if (verified) {
      log(hash, 'cyan');
    } else {
      log('Failed to verify without error?', 'red');
    }
  }).catch(err => log('Failed to verify : ' + err, 'red'));
}).catch(err => log('Failed to hash: ' + err, 'red'));