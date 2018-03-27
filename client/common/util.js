module.exports = {
  clone (obj) {
    return JSON.parse(JSON.stringify(obj));
  },
  distinct (array) {
    return array.reduce(function(a,b){if(a.indexOf(b)<0)a.push(b);return a;},[]);
  },
  trimUsage (usage) {
    const unusedGenres = [];
    Object.entries(usage).forEach(({ 0: genreId, 1: selections }) => {
      const entries = Object.entries(selections);
      entries.forEach(({ 0: movementId, 1: isSelected }) => {
        if (!isSelected) {
          delete selections[movementId];
        }
      });
      if (entries.filter(({ 1: isSelected }) => isSelected === true).length === 0) {
        unusedGenres.push(genreId);
      }
    });
    unusedGenres.forEach(genreId => delete usage[genreId]);
  },
  multi (...args) {
    return [...args].join(' ');
  }
};