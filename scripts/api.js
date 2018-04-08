const database = require('../server/database');
const api = require('../server/api');

console.clear();

database.then(async () => {
  // api.clearExercises();
//  api.getExercises().then(data => console.log(data));
  const exercise = await api.getExerciseUsage({id:11});
  console.log(exercise);
});