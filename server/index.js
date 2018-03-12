require('./bootstrap')
  .then(() => {
    console.log('ready!');
  })
  .catch(err => {
    console.error(err);
    process.exit(-1);
  });