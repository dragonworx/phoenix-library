const query = require('./query');
const password = require('./password');
// const log = require('./log');
const util = require('../client/common/util');

const TABLE = {
  USER: 'users',
  EXERCISE: 'exercise',
  LABEL: 'label',
  EXERCISE_LABEL: 'exercise_label',
};

function hashById (rows) {
  const hash = {};
  rows.forEach(row => hash[row.id] = row);
  return hash;
}

module.exports = {
  clearExercises () {
    return query.clear(TABLE.EXERCISE_LABEL)
      .then(() => {
        return query.clear(TABLE.EXERCISE);
      });
  },
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
  addExercise (name, springs, description, photo, video, usage) {
    // TODO: create thumbnail, reduce size, upload images to S3...
    return query.insert(TABLE.EXERCISE, { name, springs, description, video })
      .then(exerciseId => {
        const exerciseLabelData = [];
        Object.entries(usage).map(({ 0: genreId, 1: selectedMovementCategories }) => {
          Object.entries(selectedMovementCategories).forEach(({ 0: movementId }) => {
            exerciseLabelData.push({
              exercise_id: exerciseId,
              genre_id: genreId,
              movement_id: movementId
            });
          });
        });
        return query.inserts(TABLE.EXERCISE_LABEL, exerciseLabelData).then(() => {
          return exerciseId;
        });
      });
  },
  getExercises () {
    return query.select(TABLE.EXERCISE, ['id', 'name', 'springs', 'description', 'thumbnail', 'photo', 'video'])
      .then(exercises => {
        const exerciseById = hashById(exercises);
        exercises.forEach(exercise => {
          exercise.genre = [];
          exercise.movement = [];
          exercise.usage = {};
        });
        return this.getLabels()
          .then(labels => {
            const labelsById = hashById(labels);
            return Promise.all(exercises.map(exercise => {
              return query.select(TABLE.EXERCISE_LABEL, ['exercise_id', 'genre_id', 'movement_id'], { exercise_id: exercise.id });
            }))
              .then(exerciseLabelsPerExercise => {
                exerciseLabelsPerExercise.forEach(exerciseLabels => {
                  exerciseLabels.forEach(exerciseLabel => {
                    const exercise = exerciseById[exerciseLabel.exercise_id];
                    const genre = labelsById[exerciseLabel.genre_id];
                    const movement = labelsById[exerciseLabel.movement_id];
                    exercise.genre.push(genre.name);
                    exercise.movement.push(movement.name);
                    if (!exercise.usage[genre.id]) {
                      exercise.usage[genre.id] = {};
                    }
                    exercise.usage[genre.id][movement.id] = true;
                  });
                });
                exercises.forEach(exercise => {
                  exercise.genre.sort();
                  exercise.movement.sort();
                  // exercise.genre = util.distinct(exercise.genre);
                  // exercise.movement = util.distinct(exercise.movement);
                });
                return {
                  exercises,
                  labels
                };
              });
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