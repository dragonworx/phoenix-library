const database = require('../server/database');
const models = require('../server/models');
const query = require('../server/query');
const log = require('../server/log');

const exercises = require('../sql/exercises_remote.json');
const exerciseLabels = require('../sql/exerciseLabels_remote.json');
const labels = require('../sql/label_remote.json');

database.then(() => {
  function installRoot () {
    models.Users.create({
      firstName: 'Liz',
      lastName: 'Chamas',
      email: 'magnoliasoup@gmail.com',
      password: 'pbkdf2$10000$b38c4931c3346ce44b32235b4859ca55b01417bc9c4d69972a26eb79cba9bc5642c3ed31b9c0d84e9e311571400334e04c2b423a339ac53c93173db863287558$a5ad0fc8634bb4914c06b13c7b94cba83e9908f1147b3612504f7577084796ad5b1caf4160b338c92e7efa94d08aef20bd3fb1c05c63241606099988e556c091$sha512',
      isSuper: true,
      isAdmin: true,
      isDesigner: true,
    });
  }

  function installLabels () {
    models.Labels.bulkCreate([
      { type: 0, name: 'Pump' },
      { type: 0, name: 'Jump' },
      { type: 0, name: 'Connect' },
      { type: 0, name: 'Freestyle' },
      { type: 0, name: 'Technique' },
      { type: 1, name: 'Warm Up' },
      { type: 1, name: 'Supine Legs' },
      { type: 1, name: 'Supine Arms & Abs' },
      { type: 1, name: 'Weight Bearing Arms' },
      { type: 1, name: 'Seated / Knealing' },
      { type: 1, name: 'Prone' },
      { type: 1, name: 'Full Body / Standing' },
    ]);
  }

  async function importExercises () {
    await models.Exercises.destroy({ truncate: true });
    await models.ExerciseLabels.destroy({ truncate: true });
    await models.Labels.destroy({ truncate: true });

    await models.Exercises.bulkCreate(exercises);
    await models.ExerciseLabels.bulkCreate(exerciseLabels);
    await models.Labels.bulkCreate(labels);
    
    const setSequence = async (items, sequenceName) => {
      let id = 0;
      items.forEach(item => id = Math.max(id, item.id));
      await query.raw(`SELECT setval('${sequenceName}', ${id}, true);`, query.SELECT);
    };
    
    await setSequence(exercises, 'exercises_id_seq');
    await setSequence(exerciseLabels, 'exercise_labels_id_seq');
    await setSequence(labels, 'labels_id_seq');

    log('Done');
  }

  // installRoot ();
  // installLabels();
  importExercises();
});