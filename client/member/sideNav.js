import React from 'react';
import { Link } from 'react-router-dom';
import { withStyles } from 'material-ui/styles';
import { MenuList, MenuItem } from 'material-ui/Menu';
import List, { ListItem, ListItemIcon, ListItemText } from 'material-ui/List';
import Divider from 'material-ui/Divider';
import HomeIcon from 'material-ui-icons/PlaylistAddCheck';
import UsersIcon from 'material-ui-icons/Group';
import ExercisesIcon from 'material-ui-icons/Accessibility';
import LogoutIcon from 'material-ui-icons/Lock';

const focusColor = '#ffc688';

function menuItemClassName (url, classes, defaultClassName) {
  return (location.pathname === url ? classes.selected : '') + ' ' + classes[defaultClassName];
}

function SideNav(props) {
  const { classes } = props;
  return (
    <div className={classes.root}>
      <MenuList component="nav">
        <Link to="/admin"  className={classes.link}>
          <MenuItem button className={menuItemClassName('/admin', classes, 'menuItem')}>
            <ListItemIcon className={classes.icon}>
              <HomeIcon />
            </ListItemIcon>
            <ListItemText classes={{ primary: classes.primary }} primary="Home" />
          </MenuItem>
        </Link>
        <Link to="/admin/users" className={classes.link}>
          <MenuItem button className={menuItemClassName('/admin/users', classes, 'menuItem')}>
            <ListItemIcon className={classes.icon}>
              <UsersIcon />
            </ListItemIcon>
            <ListItemText classes={{ primary: classes.primary }} primary="Users" />
          </MenuItem>
        </Link>
        <Link to="/admin/exercises" className={classes.link}>
          <MenuItem button className={menuItemClassName('/admin/exercises', classes, 'menuItem')}>
            <ListItemIcon className={classes.icon}>
              <ExercisesIcon />
            </ListItemIcon>
            <ListItemText classes={{ primary: classes.primary }} primary="Exercises" />
          </MenuItem>
        </Link>
      </MenuList>
      <Divider />
      <List component="nav">
        <ListItem button component="a" href="/logout">
          <ListItemIcon className={classes.icon}>
            <LogoutIcon />
          </ListItemIcon>
          <ListItemText classes={{ primary: classes.primary }} primary="Logout" />
        </ListItem>
      </List>
    </div>
  );
}

export default withStyles(theme => ({
  root: {
    width: '100%',
    maxWidth: 360,
    backgroundColor: theme.palette.background.paper,
  },
  menuItem: {
    '&:focus': {
      backgroundColor: focusColor,
      '& $primary, & $icon': {
        color: theme.palette.common.white,
      },
    },
  },
  selected: {
    backgroundColor: focusColor,
    '& h3, & $icon': {
      color: 'white',
    }
  },
  link: {
    textDecoration: 'none',
  },
  primary: {},
  icon: {},
}))(SideNav);