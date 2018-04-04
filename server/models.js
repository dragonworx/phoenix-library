// load definitions
const log = require('./log');
const Ping = require('./model/ping');
const User = require('./model/user');
const Label = require('./model/label');
const Exercise = require('./model/exercise');
const ExerciseLabel = require('./model/exerciseLabel');
const Class = require('./model/class');
const ClassExerciseGroup = require('./model/ClassExerciseGroup');
const ClassGroupExercise = require('./model/classGroupExercise');
const model = require('./model');

// create model map
const Models = {
  Ping,
  User,
  Label,
  Exercise,
  ExerciseLabel,
  Class,
  ClassExerciseGroup,
  ClassGroupExercise,
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