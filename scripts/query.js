const database = require('../server/database');
const query = require('../server/query');

database.then(() => {
  // for (let i = 0; i < 5; i++) {
  //   query.insert('test', { foo: 'efg' + i })
  //   .then(id => console.log(id));
  // }

  // query.select('test', ['foo'], { id: 2 })
  //   .then(rows => console.log(rows));

  // query.update('test', { foo: 'xyz', bar: '123' }, { id: 2 })
  //   .then(rowsAffected => console.log(rowsAffected));

  query.delete('test', [5, 6])
    .then(() => console.log('done.'));
});