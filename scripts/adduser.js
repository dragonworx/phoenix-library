const database = require('../server/database');
const model = require('../server/model');
const log = require('../server/log');
const password = require('../server/password');

const firstname = process.argv[2];
const lastname = process.argv[3];
const email = process.argv[4];
const passw = process.argv[5];
const permissions = process.argv[6];

database.then(async () => {
  password.hash(passw).then(hash => {
    password.verify(passw, hash).then(async verified => {
      if (verified) {
        const userInfo = {
          firstName: firstname,
          lastName: lastname,
          email: email,
          password: hash,
          permissions: permissions,
        };
        const user = await model.User.create(userInfo);
        userInfo.id = user.id;
        log(JSON.stringify(userInfo, null, 4), 'cyan');
        process.exit(0);
      } else {
        log('Failed to verify without error?', 'red');
        process.exit(-1);
      }
    }).catch(err => log('Failed to verify : ' + err, 'red'));
  }).catch(err => log('Failed to hash: ' + err, 'red'));
});