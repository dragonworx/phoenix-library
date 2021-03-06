// load definitions
const Ping = require('./model/ping');
const User = require('./model/user');
const Label = require('./model/label');
const Exercise = require('./model/exercise');
const ExerciseLabel = require('./model/exerciseLabel');
const Class = require('./model/class');
const ClassMovementCategory = require('./model/classMovementCategory');
const ClassExercise = require('./model/classExercise');
const Template = require('./model/template');
const ClassTemplate = require('./model/classTemplate');

const model = require('./model');

// create model map
const Models = {
  Ping,
  User,
  Label,
  Exercise,
  ExerciseLabel,
  Class,
  ClassMovementCategory,
  ClassExercise,
  Template,
  ClassTemplate
};

module.exports = {
  load (sequelize, Sequelize, options) {
    const tasks = [];

    Object.entries(Models)
      .forEach(({ 0: name }) => {
        const Model = Models[name](sequelize, Sequelize);
        model[name] = Model;
        tasks.push(Model.sync(options));
      });

    return Promise.all(tasks);
  },
};