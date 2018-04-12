const FORBIDDEN = 0;
const READ = 1;
const READ_WRITE = 2;
const READ_WRITE_DELETE = 3;

// permissions = 3 integers, of the above
// lowest 000, highest 333

// exercise, class, user

module.exports = str => {
  if (!str.match(/[0-3]{3}/)) {
    throw new Error(`Invalid permissions value: ${str}`);
  }

  const exerciseLevel = parseInt(str.charAt(0), 10);
  const classLevel = parseInt(str.charAt(1), 10);
  const userLevel = parseInt(str.charAt(2), 10);

  const isForbiddenExercise = exerciseLevel === FORBIDDEN;
  const isExerciseReadOnly = exerciseLevel === READ;
  const canReadExercise = exerciseLevel >= READ;
  const canWriteExercise = exerciseLevel >= READ_WRITE;
  const canDeleteExercise = exerciseLevel === READ_WRITE_DELETE;

  const isForbiddenClass = classLevel === FORBIDDEN;
  const isClassReadOnly = classLevel === READ;
  const canReadClass = classLevel >= READ;
  const canWriteClass = classLevel >= READ_WRITE;
  const canDeleteClass = classLevel === READ_WRITE_DELETE;

  const isForbiddenUser = userLevel === FORBIDDEN;
  const isUserReadOnly = userLevel === READ;
  const canReadUser = userLevel >= READ;
  const canWriteUser = userLevel >= READ_WRITE;
  const canDeleteUser = userLevel === READ_WRITE_DELETE;

  const isAdmin = (exerciseLevel >= READ_WRITE) 
    || (classLevel >= READ_WRITE) 
    || (userLevel >= READ_WRITE);


  return {
    exerciseLevel,
    classLevel,
    userLevel,
    isAdmin,
    isForbiddenExercise,
    isExerciseReadOnly,
    canReadExercise,
    canWriteExercise,
    canDeleteExercise,
    isForbiddenClass,
    isClassReadOnly,
    canReadClass,
    canWriteClass,
    canDeleteClass,
    isForbiddenUser,
    isUserReadOnly,
    canReadUser,
    canWriteUser,
    canDeleteUser,
  };
};