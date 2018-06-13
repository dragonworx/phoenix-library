const Sequelize = require('sequelize');
const password = require('./password');
const log = require('./log');
const storage = require('./storage');
const model = require('./model');
const { clone } = require('../client/common/util');
const Op = Sequelize.Op;
// const PLAIN = { plain: true };

// const CLASS_MODE = {
//   SUBMITTED: 'submitted',
// };

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
    let exercises = await model.Exercise.findAll({ raw: true });

    exercises = exercises.map(exercise => {
      exercise.genre = [];
      exercise.movement = [];
      exercise.usage = {};
      return exercise;
    });

    const exerciseById = hashById(exercises);

    let labels = await model.Label.findAll({ raw: true });
    // labels = labels.map(label => label.get(PLAIN));
    const labelsById = hashById(labels);
    const exerciseLabelsPerExercise = await Promise.all(exercises.map(
        exercise => model.ExerciseLabel.findAll({
          where: {
            exerciseId: exercise.id
          },
          raw: true
        })
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

  async getExerciseUsage (exercise) {
    exercise.genre = [];
    exercise.movement = [];
    exercise.usage = {};

    let labels = await model.Label.findAll({ raw: true });
    // labels = labels.map(label => label.get(PLAIN));
    const labelsById = hashById(labels);
    const exerciseLabels = await model.ExerciseLabel.findAll({ where: { exerciseId: exercise.id }});

    exerciseLabels.forEach(
      exerciseLabel => {
        const genre = labelsById[exerciseLabel.genreId];
        const movement = labelsById[exerciseLabel.movementId];
        exercise.genre.push(genre.name);
        exercise.movement.push(movement.name);
        if (!exercise.usage[genre.id]) {
          exercise.usage[genre.id] = {};
        }
        exercise.usage[genre.id][movement.id] = true;
      }
    );

    exercise.genre.sort();
    exercise.movement.sort();

    return exercise;
  },

  async getClasses () {
    let classes = await model.Class.findAll({
      order: Sequelize.col('id'),
      raw: true
    });
    return classes;
  },

  async getUsers () {
    let users = await model.User.findAll({
      order: Sequelize.col('id'),
      raw: true
    });
    return users;
  },

  async getClass (id) {
    const cls = await model.Class.findOne({
      where: {
        id
      },
      raw: true
    });
    if (!cls) {
      throw new Error('Class not found: ' + id);
    }
    log(cls);
    cls.program = await this.getClassProgram(id);
    return cls;
  },

  async getLabels (type) {
    let labels = await model.Label.findAll({ where: { type }, raw: true/*, order: Sequelize.col('name')*/ });
    return labels;
  },

  async getAllLabels () {
    let labels = await model.Label.findAll({
      /*order: Sequelize.col('name'),*/
      raw: true
    });
    return labels;
  },

  async getCounts () {
    const exercises = await model.Exercise.count();
    const classes = await model.Class.count();
    const users = await model.User.count();
    return {
      exercises,
      classes,
      users,
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
    const exercise = await model.Exercise.create({
      name, 
      springs, 
      description, 
      video,
      revision: 1,
    });

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
    const exercise = await model.Exercise.findOne({
      where: {
        id: exerciseId
      }
    });

    exercise.set({
      name,
      springs,
      description,
      video,
      revision: exercise.revision + 1
    });

    // destroy labels, re-create
    await model.ExerciseLabel.destroy({
      where: {
        exerciseId
      }
    });

    await this.createExerciseLabels(exerciseId, usage);

    // save with no photo changes
    if (!photo) {
      exercise.save();
      return exercise.revision;
    }

    // save with photo changes
    await this.uploadPhoto(exerciseId, photo);
    exercise.photo = photo.name;
    exercise.save();

    return exercise.revision;
  },

  async deleteExercises (ids) {
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
      },
      raw: true
    });
    labels.forEach(label => ids[label.exerciseId] = true);
    const idsArray = Object.keys(ids);
    let exercises = await model.Exercise.findAll({
      where: {
        id: {
          [Op.in]: idsArray
        }
      },
      order: Sequelize.col('id'),
      raw: true
    });
    exercises = exercises.map(exercise => {
      exercise = clone(exercise);
      exercise.repetitions = 1;
      exercise.duration = 1;
      exercise.notes = '';
      return exercise;
    });
    // exercises.sort((a, b) => {
    //   if (a.name < b.name) {
    //     return -1;
    //   } else if (a.name > b.name) {
    //     return 1;
    //   }
    //   return 0;
    // });
    exercises.forEach((exercise, i) => exercise.index = i);
    return exercises;
  },

  async getClassCategories (genreId) {
    const exerciseLabels = await model.ExerciseLabel.findAll({
      where: {
        genreId
      },
      attributes: ['movementId'],
      raw: true
    });

    const labelIds = exerciseLabels.map(label => label.movementId);
    let labels = await model.Label.findAll({
      where: {
        id: {
          [Op.in]: labelIds
        },
      },
      order: Sequelize.col('id'),
      raw: true
    });

    return labels;
  },

  async addClass (cls) {
    const categorySummary = [];
    let durationSummary = 0;

    cls.categories.forEach(category => {
      if (categorySummary.indexOf(category.name) === -1) {
        categorySummary.push(category.name);
      }
      category.exercises.forEach(exercise => {
        durationSummary += exercise.duration;
      });
    });


    const newCls = await model.Class.create({
      name: cls.name,
      status: cls.status,
      genreId: cls.genreId,
      createdBy: cls.createdBy,
      categorySummary: categorySummary.join(','),
      durationSummary,
      notes: cls.notes, 
      revision: 1,
    });

    await Promise.all(cls.categories.map(async category => {
      const classMovementCategory = await model.ClassMovementCategory.create({
        labelId: category.labelId,
        classId: newCls.id,
        index: category.index,
      });

      return Promise.all(category.exercises.map(async exercise => {
        await model.ClassExercise.create({
          index: exercise.index,
          exerciseId: exercise.id,
          classMovementCategoryId: classMovementCategory.id,
          notes: exercise.notes,
          duration: exercise.duration,
          repetitions: exercise.repetitions,
        });
      }));
    }));

    return {
      id: newCls.id,
      categorySummary: newCls.categorySummary,
      durationSummary: durationSummary,
    };
  },

  async editClass (cls) {
    const categorySummary = [];
    let durationSummary = 0;

    cls.categories.forEach(category => {
      if (categorySummary.indexOf(category.name) === -1) {
        categorySummary.push(category.name);
      }
      category.exercises.forEach(exercise => {
        durationSummary += exercise.duration;
      });
    });

    const existingCls = await model.Class.findOne({ where: { id: cls.id } });
    existingCls.name = cls.name;
    existingCls.categorySummary = categorySummary.join(',');
    existingCls.durationSummary = durationSummary;
    existingCls.notes = cls.notes;
    existingCls.status = cls.status;
    existingCls.revision = existingCls.revision + 1;
    await existingCls.save();

    await this.deleteClassProgram([cls.id]);

    await Promise.all(cls.categories.map(async category => {
      const classMovementCategory = await model.ClassMovementCategory.create({
        labelId: category.labelId,
        classId: existingCls.id,
        index: category.index,
      });

      return Promise.all(category.exercises.map(async exercise => {
        await model.ClassExercise.create({
          index: exercise.index,
          exerciseId: exercise.id,
          classMovementCategoryId: classMovementCategory.id,
          notes: exercise.notes,
          duration: exercise.duration,
          repetitions: exercise.repetitions,
        });
      }));
    }));

    return {
      categorySummary: existingCls.categorySummary,
      durationSummary: durationSummary,
      revision: existingCls.revision,
    };
  },

  async deleteClasses (ids) {
    await model.Class.destroy({
      where: {
        id: {
          [Op.or]: ids
        }
      }
    });

    this.deleteClassProgram(ids);
  },

  async deleteClassProgram (ids) {
    const classMovementCategories = await model.ClassMovementCategory.findAll({
      where: {
        classId: {
          [Op.or]: ids
        }
      },
      attributes: ['id'],
      raw: true
    });

    const classMovementCategoryIds = classMovementCategories.map(category => category.id);

    await model.ClassMovementCategory.destroy({
      where: {
        classId: {
          [Op.or]: ids
        }
      }
    });

    await model.ClassExercise.destroy({
      where: {
        classMovementCategoryId: {
          [Op.or]: classMovementCategoryIds
        }
      }
    });
  },

  async getClassProgram (classId) {
    const program = [];
    const classMovementCategories = await model.ClassMovementCategory.findAll({ where: { classId }, raw: true, order: Sequelize.col('index') });
    for (let i = 0; i < classMovementCategories.length; i++) {
      const classMovementCategory = classMovementCategories[i];
      const classExercises = await model.ClassExercise.findAll({ where: { classMovementCategoryId: classMovementCategory.id }, raw: true, order: Sequelize.col('index'), });
      const exercises = [];
      for (let j = 0; j < classExercises.length; j++) {
        const classExercise = classExercises[j];
        const exercise = await model.Exercise.findOne({ where: { id: classExercise.exerciseId }, raw: true });
        exercise.index = classExercise.index;
        exercise.repetitions = classExercise.repetitions;
        exercise.duration = classExercise.duration;
        exercise.notes = classExercise.notes;
        exercises.push(exercise);
      }
      const label = await model.Label.findOne({ where: { id: classMovementCategory.labelId }, raw: true });
      const category = {
        name: label.name,
        labelId: classMovementCategory.labelId,
        index: classMovementCategory.index,
        exercises
      };
      program.push(category);
    }
    log({ programLength: program.length });
    return program;
  }
};