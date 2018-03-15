const password = require('happn-password-hash-and-salt');

module.exports = {
  hash (plainText) {
    return new Promise((resolve, reject) => {
      password(plainText).hash((err, hash) => {
        if (err) {
          reject(err);
        } else {
          resolve(hash);
        }
      });
    });
  },
  verify (plainText, hash) {
    return new Promise((resolve, reject) => {
      password(plainText).verifyAgainst(hash, (err, verified) => {
        if (err) {
          reject(err);
        } else {
          resolve(verified);
        }
      });
    });
  }
};