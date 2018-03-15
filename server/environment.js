module.exports = envVars => {
  const vars = {};
  envVars.forEach(varName => {
    const varValue = process.env[varName];
    if (!varValue) {
      throw new Error(`Cannot read environment variable: "${varName}"`);
    }
  });
  return vars;
};