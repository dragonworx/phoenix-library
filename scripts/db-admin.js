const database = require('../server/database');
const model = require('../server/model');
const log = require('../server/log');
const Sequelize = require('sequelize');

database.then(async () => {
  function installRoot () {
    model.User.create({
      firstName: 'Liz',
      lastName: 'Chamas',
      email: 'magnoliasoup@gmail.com',
      password: 'pbkdf2$10000$b38c4931c3346ce44b32235b4859ca55b01417bc9c4d69972a26eb79cba9bc5642c3ed31b9c0d84e9e311571400334e04c2b423a339ac53c93173db863287558$a5ad0fc8634bb4914c06b13c7b94cba83e9908f1147b3612504f7577084796ad5b1caf4160b338c92e7efa94d08aef20bd3fb1c05c63241606099988e556c091$sha512',
      permissions: '333',
    });
  }

  function installLabels () {
    model.Label.bulkCreate([
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
    await model.Exercise.destroy({ truncate: true });
    await model.ExerciseLabel.destroy({ truncate: true });
    await model.Label.destroy({ truncate: true });

    await model.Exercises.bulkCreate(exercises);
    await model.ExerciseLabels.bulkCreate(exerciseLabels);
    await model.Labels.bulkCreate(labels);
    
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

  async function addTemplates () {
    await model.Template.bulkCreate([
      // jump
      { categories: '6,13,14,15,13,10,9,14,13,14' },
      // everything else
      { categories: '6,7,8,9,10,11,12' },
    ]);

    await model.ClassTemplate.bulkCreate([
      { genreId: 1, templateId: 2 },
      { genreId: 2, templateId: 1 },
      { genreId: 3, templateId: 2 },
      { genreId: 4, templateId: 2 },
      { genreId: 5, templateId: 2 },
    ]);
  }

  async function addRevisions () {
    const Op = Sequelize.Op;
    await model.Class.update(
      { revision: 1 },
      { 
        where: {
          id: {
            [Op.gt]: 1
          }
        }
      }
    );
    await model.Exercise.update(
      { revision: 1 },
      { 
        where: {
          id: {
            [Op.gt]: 1
          }
        }
      }
    );
  }

  // installRoot ();
  // installLabels();
  // importExercises();
  await addTemplates();
  await addRevisions();
  
  log('Ok');
  process.exit(0);
});