const { select, insert, update } = require('./query');
const password = require('./password');

module.exports = {
  login (email, plainTextPassword) {
    return select('SELECT first_name, last_name, password, is_admin, is_super, is_designer, last_login FROM users WHERE email = ?;', [email])
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
  },
  addExercise (name, springs, description, photo, video) {
    // TODO: create thumbnail, reduce size, upload images to S3...
    return insert('INSERT INTO exercise (name, springs, description, video) VALUES (?, ?, ?, ?);', [
      name,
      springs,
      description,
      video
    ]);
  },
  getExercises () {
    return select('SELECT created, modified, id, name, springs, description, thumbnail, photo, video FROM exercise ORDER by id;')
      .then(array => {
        // TODO: join with exercise label data
        return Promise.resolve(array);
      });
  },
  deleteExercises (ids) {
    return select('DELETE FROM exercise WHERE id IN(:ids);', {ids});
  },
  editExercise (name, springs, description, photo, video) {
    // TODO: create thumbnail, reduce size, upload images to S3...
    return update('INSERT INTO exercise (name, springs, description, video) VALUES (?, ?, ?, ?);', [
      name,
      springs,
      description,
      video
    ]);
  },
};