const user = JSON.parse(atob(document.getElementById('phoenix-bundle').getAttribute('data-session')));

module.exports = {
  user
};