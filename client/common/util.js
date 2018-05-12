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
  },
  toOrdinal (number) {
    const s = String(number),
      len = s.length,
      end  = s.substr(len - 1, 1),
      teen = len > 1 && s.substr(len - 2, 1) === '1';
    let ord = 'th';

    if (end === "1" && !teen) {
      ord = "st";
    } else if (end === "2" && !teen) {
      ord = "nd";
    } else if (end === "3" && !teen) {
      ord = "rd";
    }

    return ord;
  },
  plural (number, postfix) {
    return number === 1 ? `${number} ${postfix}` : `${number} ${postfix}s`;
  }
};

module.exports.combineCss = module.exports.multi;
module.exports.css = module.exports.combineCss;