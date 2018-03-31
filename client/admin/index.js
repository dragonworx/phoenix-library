import React from 'react';
import {
  BrowserRouter as Router,
  Route,
} from 'react-router-dom';
import PropTypes from 'prop-types';
import classNames from 'classnames';
import { withStyles } from 'material-ui/styles';
import AppBar from 'material-ui/AppBar';
import Toolbar from 'material-ui/Toolbar';
import Typography from 'material-ui/Typography';
import Avatar from 'material-ui/Avatar';
import PingStatus from '../common/ping';
import { user } from '../common/session';
import TabsView from './tabs';

const drawerWidth = 180;

class Admin extends React.PureComponent {
  state = {
  };

  render () {
    const { classes } = this.props;
  
    return (
      <Router>
        <div className={classes.root}>
          <AppBar position="absolute" className={classes.appBar}>
            <Toolbar>
              <Avatar
                alt={`${user.firstName} ${user.lastName}`}
                src="/img/icon/48x48.png"
                className={classNames(classes.avatar, classes.bigAvatar)}
              />
              <Typography variant="title" color="inherit" noWrap>
                {`Welcome${user.lastLogin ? ' back' : ''} ${user.firstName}`}
              </Typography>
            </Toolbar>
            <PingStatus />
          </AppBar>
          <main className={classes.content}>
            <div className={classes.toolbar} />
            <Route exact path="/admin" component={TabsView}/>
          </main>
        </div>
      </Router>
    );
  }
}

Admin.propTypes = {
  classes: PropTypes.object.isRequired,
};

export default withStyles(theme => ({
  root: {
    flexGrow: 1,
    height: '100%',
    zIndex: 1,
    overflow: 'hidden',
    position: 'relative',
    display: 'flex',
  },
  appBar: {
    zIndex: theme.zIndex.drawer + 1,
    backgroundColor: 'orange'
  },
  drawerPaperOpen: {
    position: 'relative',
    width: drawerWidth,
    transition: 'width 0.5s ease'
  },
  drawerPaperClosed: {
    position: 'relative',
    width: 0,
    transition: 'width 0.5s ease'
  },
  content: {
    flexGrow: 1,
    backgroundColor: theme.palette.background.default,
    minWidth: 0, // So the Typography noWrap works
  },
  toolbar: theme.mixins.toolbar,
  avatar: {
    margin: 10,
  },
  bigAvatar: {
    width: 48,
    height: 48,
  },
  showHideMenuButton: {
    position: 'absolute',
    left: 6,
    bottom: 2,
    cursor: 'pointer',
  },
  showHideMenuButtonClosed: {
    opacity: 0.5
  },
  showHideMenuButtonOpen: {
    opacity: 1
  },
}))(Admin);