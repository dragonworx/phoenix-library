const Sequelize = require('sequelize');
const password = require('./password');
const log = require('./log');
const storage = require('./storage');
const model = require('./model');

function hashById (rows) {
  const hash = {};
  rows.forEach(row => hash[row.id] = row);
  return hash;
}

module.exports = {
  async ping () {
    await model.Ping.destroy({ truncate: true });
    model.Ping.create({ lastPing: Date.now() });
  },

  async login (email, plainTextPassword) {
    const user = await model.User.findOne({ where: { email } });

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
    
    let exercises = await model.Exercise.findAll();

    exercises = exercises.map(exercise => {
      exercise = exercise.get(PLAIN);
      exercise.genre = [];
      exercise.movement = [];
      exercise.usage = {};
      return exercise;
    });

    const exerciseById = hashById(exercises);

    let labels = await model.Label.findAll();
    labels = labels.map(label => label.get(PLAIN));
    const labelsById = hashById(labels);
    const exerciseLabelsPerExercise = await Promise.all(exercises.map(
      exercise => 
      model.ExerciseLabel.findAll({ where: { exerciseId: exercise.id }})
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
      labels,
      count: exercises.length
    };
  },

  async getClasses () {
    let classes = await model.Class.findAll();
    return classes;
  },

  async getLabels (type) {
    let labels = await model.Label.findAll({ where: { type } });
    return labels;
  },

  async getCounts () {
    const exercises = await model.Exercise.count();
    const classes = await model.Class.count();
    return {
      exercises,
      classes,
    };
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
      }),
    ]);

    log(`Successfully uploaded image "${name}" for #${exerciseId}`, 'green');
    const exercise = await model.Exercise.findOne({ where: { id: exerciseId }});
    exercise.photo = name;
    exercise.save();
    
    return Promise.resolve(exerciseId);
  },

  async addExercise (name, springs, description, photo, video, usage) {
    const exercise = await model.Exercise.create({ name, springs, description, video });
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
    // update exercise
    const exercise = await model.Exercise.findOne({ where: { id: exerciseId }});
    exercise.set({ name, springs, description, video });

    // destroy labels, re-create
    await model.destroy({ where: { exerciseId }});
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

    await model.Exercise.destroy({
      where: {
        id: {
          [Op.or]: ids
        }
      }
    });

    await model.ExerciseLabel.destroy({
      where: {
        exerciseId: {
          [Op.or]: ids
        }
      }
    });

    await Promise.all(ids.map(exerciseId => storage.deleteImages(exerciseId)));
  },

  async createExerciseLabels (exerciseId, usage) {
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
      await Promise.all(exerciseLabelData.map(settings => model.ExerciseLabel.create(settings)));
    } else {
      log(`adding no exercise labels for #${exerciseId}`);
    }

    return Promise.resolve();
  },

  async getTemplate (genreId) {
    const { templateId } = await model.ClassTemplate.findOne({ where: { genreId } });
    const { categories } = await model.Template.findOne({ where: { id: templateId } });
    const labels = await this.getLabels(1);
    const labelsById = {};
    labels.forEach(label => labelsById[label.id] = label);
    const ids = categories.split(',').map(id => parseInt(id, 10));
    return ids.map((id, i) => ({ labelId: id, name: labelsById[id].name, index: i, exercises: [] }));
  },

  async getClassCategoryExercises (genreId, movementId) {
    const ids = {};
    const labels = await model.ExerciseLabel.findAll({
      where: {
        genreId,
        movementId,
      }
    });
    labels.forEach(label => ids[label.exerciseId] = true);
    const Op = Sequelize.Op;
    const idsArray = Object.keys(ids);
    const exercises = await model.Exercise.findAll({
      where: {
        id: {
          [Op.in]: idsArray
        }
      }
    });
    return exercises;
  }
};