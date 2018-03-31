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
import TabsView from './tabView';
import HamburgerMenu from '../common/hamburgerMenu';
import { user } from './session';

const userOptions = [ 'Logout' ];

const drawerWidth = 180;

class MemberApp extends React.PureComponent {
  state = {};

  onUserMenuSelect = ({ 1: option }) => {
    if (option === 'Logout') {
      location = '/logout';
    }
  };

  render () {
    const { classes, isAdmin, isSuper, isDesigner } = this.props;
  
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
                Phoenix Pilates Library ~ {user.firstName}
              </Typography>
              <HamburgerMenu className={classes.menu} options={userOptions} onSelect={this.onUserMenuSelect} />
            </Toolbar>
            <PingStatus />
          </AppBar>
          <main className={classes.content}>
            <div className={classes.toolbar} />
            <Route exact path="/admin" component={() => <TabsView isAdmin={isAdmin} isSuper={isSuper} isDesigner={isDesigner} />}/>
          </main>
        </div>
      </Router>
    );
  }
}

MemberApp.propTypes = {
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
  menu: {
    position: 'absolute',
    right: 0,
  }
}))(MemberApp);