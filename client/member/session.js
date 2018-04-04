import readPermissions from '../../common/permissions';

const user = JSON.parse(atob(document.getElementById('phoenix-bundle').getAttribute('data-session')));
const permissions = readPermissions(user.permissions);

module.exports = {
  user,
  permissions
};