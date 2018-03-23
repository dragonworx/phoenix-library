const query = require('./query');
const password = require('./password');
const log = require('./log');
const storage = require('./storage');

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
  ping () {
    return query.raw('SELECT true;', false);
  },
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
                });
                return {
                  exercises,
                  labels
                };
              });
          });
      });
  },
  addExercise (name, springs, description, photo, video, usage) {
    return query.insert(TABLE.EXERCISE, { name, springs, description, video })
      .then(exerciseId => {
        log(usage);
        return this.createExerciseLabels(exerciseId, usage)
          .then(exerciseId => {
            if (!photo) {
              return exerciseId;
            }
            const photo_full_url = storage.imageUrl(exerciseId, 'full');
            const photo_thumb_url = storage.imageUrl(exerciseId, 'thumb');
            return query.update(TABLE.EXERCISE, { photo: photo_full_url, thumbnail: photo_thumb_url }, { id: exerciseId })
              .then(() => exerciseId);
          });
      });
  },
  editExercise (exerciseId, name, springs, description, photo, video, usage) {
    return query.update(TABLE.EXERCISE, { name, springs, description, video }, { id: exerciseId })
      .then(() => {
        return query.remove(TABLE.EXERCISE_LABEL, [exerciseId], 'exercise_id')
          .then(() => {
            log(usage);
            return this.createExerciseLabels(exerciseId, usage)
              .then(exerciseId => {
                if (!photo) {
                  return exerciseId;
                }
                const photo_full_url = storage.imageUrl(exerciseId, 'full');
                const photo_thumb_url = storage.imageUrl(exerciseId, 'thumb');
                return query.update(TABLE.EXERCISE, { photo: photo_full_url, thumbnail: photo_thumb_url }, { id: exerciseId })
                  .then(() => exerciseId);
              });
          });
      });
  },
  deleteExercises (ids) {
    return query.remove(TABLE.EXERCISE, ids)
      .then(() => {
        return query.remove(TABLE.EXERCISE_LABEL, ids, 'exercise_id')
          .then(() => {
            return Promise.all(ids.map(exerciseId => storage.deleteImages(exerciseId)));
          });
      });
  },
  createExerciseLabels (exerciseId, usage) {
    const exerciseLabelData = [];
    Object.entries(usage).map(({ 0: genreId, 1: selectedMovementCategories }) => {
      Object.entries(selectedMovementCategories).forEach(({ 0: movementId, 1: isSelected }) => {
        log(movementId + ':' + isSelected);
        if (isSelected === true) {
          exerciseLabelData.push({
            exercise_id: exerciseId,
            genre_id: genreId,
            movement_id: movementId
          });
        }
      });
    });
    if (exerciseLabelData.length) {
      log(`adding ${exerciseLabelData.length} exercise labels for #${exerciseId}`);
      return query.inserts(TABLE.EXERCISE_LABEL, exerciseLabelData).then(() => {
        return exerciseId;
      });
    } else {
      log(`adding no exercise labels for #${exerciseId}`);
      return Promise.resolve(exerciseId);
    }
  },
  getLabels () {
    return query.select(TABLE.LABEL, ['id', 'type', 'name', 'description', 'color']);
  },
};