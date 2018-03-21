const database = require('../server/database');
const api = require('../server/api');

console.clear();

database.then(() => {
  api.clearExercises();
//  api.getExercises().then(data => console.log(data));
});