import readPermissions from '../../common/permissions';

const user = JSON.parse(atob(document.getElementById('phoenix-bundle').getAttribute('data-session')));
const permissions = readPermissions(user.permissions);

window.phoenix_lib = {
  user,
};

module.exports = {
  user,
  permissions
};