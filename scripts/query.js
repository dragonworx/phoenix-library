const database = require('../server/database');
const query = require('../server/query');

database.then(() => {
  query.insert("insert into test (val) values (?);", ['efg']).then(res => console.log(res));
});