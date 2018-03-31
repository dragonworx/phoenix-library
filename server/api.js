const Sequelize = require('sequelize');
const password = require('./password');
const log = require('./log');
const storage = require('./storage');
const models = require('./models');

function hashById (rows) {
  const hash = {};
  rows.forEach(row => hash[row.id] = row);
  return hash;
}

module.exports = {
  async ping () {
    const Ping = models.Ping;
    await Ping.destroy({ truncate: true });
    Ping.create({ lastPing: Date.now() });
  },

  async login (email, plainTextPassword) {
    const Users = models.Users;
    const user = await Users.findOne({ where: { email } });
    if (user) {
      const verified = await password.verify(plainTextPassword, user.password);
      if (verified) {
        user.lastLogin = new Date();
        user.save();
        const userData = user.get({ plain: true });
        delete userData.password;
        return userData;
      }
    }
    return null;
  },

  async getExercises () {
    const PLAIN = { plain: true };
    const Exercises = models.Exercises;
    const Label = models.Labels;
    const ExerciseLabel = models.ExerciseLabels;

    let exercises = await Exercises.findAll();
    exercises = exercises.map(exercise => {
      exercise = exercise.get(PLAIN);
      exercise.genre = [];
      exercise.movement = [];
      exercise.usage = {};
      return exercise;
    });
    const exerciseById = hashById(exercises);

    let labels = await Label.findAll();
    labels = labels.map(label => label.get(PLAIN));
    const labelsById = hashById(labels);
    const exerciseLabelsPerExercise = await Promise.all(exercises.map(
      exercise => 
        ExerciseLabel.findAll({ where: { exerciseId: exercise.id }})
      )
    );

    exerciseLabelsPerExercise.forEach(exerciseLabels => {
      exerciseLabels.forEach(exerciseLabel => {
        const exercise = exerciseById[exerciseLabel.exerciseId];
        const genre = labelsById[exerciseLabel.genreId];
        const movement = labelsById[exerciseLabel.movementId];
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
  },

  getExerciseCount () {
    const Exercises = models.Exercises;
    return Exercises.count();
  },

  async uploadPhoto (exerciseId, image) {
    if (!image) {
      return Promise.resolve();
    }

    const name = image.name;

    await Promise.all([
      storage.uploadImage(exerciseId, 1, 'full', image.data, {
        maxWidth: 1000,
        maxHeight: 1000,
      }),
      storage.uploadImage(exerciseId, 1, 'preview', image.data, {
        width: 600,
        maxHeight: 600,
      }),
      storage.uploadImage(exerciseId, 1, 'thumb', image.data, {
        width: 100,
        maxHeight: 100,
      })
    ]);

    log(`Successfully uploaded image "${name}" for #${exerciseId}`, 'green');
    const Exercises = models.Exercises;
    const exercise = await Exercises.findOne({ where: { id: exerciseId }});
    exercise.photo = name;
    exercise.save();
    return Promise.resolve(exerciseId);
  },

  async addExercise (name, springs, description, photo, video, usage) {
    const Exercises = models.Exercises;
    const exercise = await Exercises.create({ name, springs, description, video });
    const exerciseId = exercise.id;
    await this.createExerciseLabels(exerciseId, usage);
    if (!photo) {
      return exerciseId;
    }
    await this.uploadPhoto(exerciseId, photo);
    exercise.photo = photo.name;
    return exerciseId;
  },

  async editExercise (exerciseId, name, springs, description, photo, video, usage) {
    const Exercises = models.Exercises;
    const ExerciseLabels = models.ExerciseLabels;

    // update exercise
    const exercise = await Exercises.findOne({ where: { id: exerciseId }});
    exercise.set({ name, springs, description, video });

    // destroy labels, re-create
    await ExerciseLabels.destroy({ where: { exerciseId }});
    await this.createExerciseLabels(exerciseId, usage);

    // save with no photo changes
    if (!photo) {
      exercise.save();
      return exerciseId;
    }

    // save with photo changes
    await this.uploadPhoto(exerciseId, photo);
    exercise.photo = photo.name;
    exercise.save();
    return exerciseId;
  },

  async deleteExercises (ids) {
    const Op = Sequelize.Op;
    const Exercises = models.Exercises;
    const ExerciseLabels = models.ExerciseLabels;
    await Exercises.destroy({
      where: {
        id: {
          [Op.or]: ids
        }
      }
    });
    await ExerciseLabels.destroy({
      where: {
        exerciseId: {
          [Op.or]: ids
        }
      }
    });
    await Promise.all(ids.map(exerciseId => storage.deleteImages(exerciseId)));
  },

  async createExerciseLabels (exerciseId, usage) {
    const ExerciseLabels = models.ExerciseLabels;
    const exerciseLabelData = [];
    Object.entries(usage).map(({ 0: genreId, 1: selectedMovementCategories }) => {
      Object.entries(selectedMovementCategories).forEach(({ 0: movementId, 1: isSelected }) => {
        log(movementId + ':' + isSelected);
        if (isSelected === true) {
          exerciseLabelData.push({
            exerciseId: exerciseId,
            genreId: genreId,
            movementId: movementId
          });
        }
      });
    });
    if (exerciseLabelData.length) {
      log(`adding ${exerciseLabelData.length} exercise labels for #${exerciseId}`);
      await Promise.all(exerciseLabelData.map(settings => ExerciseLabels.create(settings)));
    } else {
      log(`adding no exercise labels for #${exerciseId}`);
    }
    return Promise.resolve();
  },
};