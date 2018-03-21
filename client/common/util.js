module.exports = {
  clone (obj) {
    return JSON.parse(JSON.stringify(obj));
  },
  distinct (array) {
    return array.reduce(function(a,b){if(a.indexOf(b)<0)a.push(b);return a;},[]);
  }
};