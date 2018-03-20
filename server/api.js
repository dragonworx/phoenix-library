const query = require('./query');
const password = require('./password');
const TABLE = {
  USER: 'users',
  EXERCISE: 'exercise',
  LABEL: 'label',
};

module.exports = {
  login (email, plainTextPassword) {
    return query.select(TABLE.USER, ['first_name', 'last_name', 'password', 'is_admin', 'is_super', 'is_designer', 'last_login'], { email })
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
    return query.insert(TABLE.EXERCISE, { name, springs, description, video });
  },
  getExercises () {
    return query.select(TABLE.EXERCISE, ['id', 'name', 'springs', 'description', 'thumbnail', 'photo', 'video'])
      .then(exercises => {
        // TODO: join with exercise label data...add genre and movement cat virtual columns to exercises before sending...
        return this.getLabels()
          .then(labels => {
            return {
              exercises,
              labels
            };
          });
      });
  },
  deleteExercises (ids) {
    return query.remove(TABLE.EXERCISE, ids);
  },
  editExercise (id, name, springs, description, photo, video) {
    // TODO: create thumbnail, reduce size, upload images to S3...
    return query.update(TABLE.EXERCISE, { name, springs, description, video }, { id });
  },
  getLabels () {
    return query.select(TABLE.LABEL, ['id', 'type', 'name', 'description', 'color']);
  },
};