const Models = {
  Ping: require('./model/ping'),
  Users: require('./model/user'),
  Labels: require('./model/label'),
  Exercises: require('./model/exercise'),
  ExerciseLabels: require('./model/exerciseLabel'),
};

const models = {};

module.exports = {
  load (sequelize, Sequelize, options) {
    const tasks = [];
    Object.entries(Models)
      .forEach(({ 0: name }) => {
        const Model = Models[name](sequelize, Sequelize, models);
        models[name] = Model;
        this[name] = Model;
        tasks.push(Model.sync(options));
      });
    return Promise.all(tasks);
  },
};