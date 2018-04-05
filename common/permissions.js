const FORBIDDEN = 0;
const READ = 1;
const READ_WRITE = 2;
const READ_WRITE_DELETE = 3;

// permissions = 3 integers, of the above
// lowest 000, highest 333

module.exports = str => {
  if (!str.match(/[0-3]{3}/)) {
    throw new Error(`Invalid permissions value: ${str}`);
  }

  const exerciseLevel = parseInt(str.charAt(0), 10);
  const classeLevel = parseInt(str.charAt(1), 10);
  const userLevel = parseInt(str.charAt(2), 10);

  const isForbiddenExercise = exerciseLevel === FORBIDDEN;
  const isExerciseReadOnly = exerciseLevel === READ;
  const canReadExercise = exerciseLevel >= READ;
  const canWriteExercise = exerciseLevel >= READ_WRITE;
  const canDeleteExercise = exerciseLevel === READ_WRITE_DELETE;

  const isForbiddenClass = classeLevel === FORBIDDEN;
  const isClassReadOnly = classeLevel === READ;
  const canReadClass = classeLevel >= READ;
  const canWriteClass = classeLevel >= READ_WRITE;
  const canDeleteClass = classeLevel === READ_WRITE_DELETE;

  const isForbiddenUser = userLevel === FORBIDDEN;
  const isUserReadOnly = userLevel === READ;
  const canReadUser = userLevel >= READ;
  const canWriteUser = userLevel >= READ_WRITE;
  const canDeleteUser = userLevel === READ_WRITE_DELETE;

  const isAdmin = (exerciseLevel >= READ_WRITE) 
    || (classeLevel >= READ_WRITE) 
    || (userLevel >= READ_WRITE);


  return {
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