const user = JSON.parse(atob(document.getElementById('admin-bundle').getAttribute('data-session')));

module.exports = {
  user
};