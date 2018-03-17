const { select } = require('./query');
const password = require('./password');

module.exports = {
  login (email, plainTextPassword) {
    return select('SELECT first_name, last_name, password, is_admin, is_super, is_designer, last_login FROM users WHERE email = ?', [email])
      .then(data => {
        if (data.length) {
          const user = data[0];
          return password.verify(plainTextPassword, user.password).then(verified => {
            if (verified) {
              delete user.password;
              user.success = true;
              user.email = email;
              return user;
            } else {
              return null;
            }
          });
        } else {
          return null;
        }
      });
  }
};