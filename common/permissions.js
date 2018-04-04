module.exports = str => {
  if (!str.length === 3) {
    throw new Error('Invalid permissions value: ' + str);
  }
  const exercises = str.charAt(0) === '1';
  const classes = str.charAt(1) === '1';
  const users = str.charAt(2) === '1';
  const admin = exercises || classes || users;
  return {
    exercises,
    classes,
    users,
    admin,
  };
};