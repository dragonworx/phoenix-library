import React from 'react';
import {
  BrowserRouter as Router,
  Route,
} from 'react-router-dom';
import PropTypes from 'prop-types';
import classNames from 'classnames';
import { withStyles } from 'material-ui/styles';
import Drawer from 'material-ui/Drawer';
import AppBar from 'material-ui/AppBar';
import Tooltip from 'material-ui/Tooltip';
import Toolbar from 'material-ui/Toolbar';
import Typography from 'material-ui/Typography';
import MenuIcon from 'material-ui-icons/Storage';
import Avatar from 'material-ui/Avatar';
import PingStatus from '../common/ping';
import SideNav from './sideNav';
import { user } from '../common/session';
import Exercises from './exercises';

const drawerWidth = 180;

class Admin extends React.PureComponent {
  state = {
    showMenu: true,
  };

  onShowHideMenuClick = () => {
    this.setState({ showMenu: !this.state.showMenu });
  };

  render () {
    const { showMenu } = this.state;
    const { classes } = this.props;
  
    return (
      <Router>
        <div className={classes.root}>
          <AppBar position="absolute" className={classes.appBar}>
            <Toolbar>
              <Avatar
                alt={`${user.first_name} ${user.last_name}`}
                src="/img/icon/48x48.png"
                className={classNames(classes.avatar, classes.bigAvatar)}
              />
              <Typography variant="title" color="inherit" noWrap>
                {`Welcome${user.last_login ? ' back' : ''} ${user.first_name}`}
              </Typography>
              <Tooltip title="Show / Hide Side Menu" placement="right">
                <MenuIcon className={[classes.showHideMenuButton, showMenu ? classes.showHideMenuButtonOpen : classes.showHideMenuButtonClosed].join(' ')} onClick={this.onShowHideMenuClick} />
              </Tooltip>
            </Toolbar>
            <PingStatus />
          </AppBar>
          <Drawer
            variant="permanent"
            classes={{
              paper: showMenu ? classes.drawerPaperOpen : classes.drawerPaperClosed,
            }}
          >
            <div className={classes.toolbar} />
            <SideNav />
          </Drawer>
          <main className={classes.content}>
            <div className={classes.toolbar} />
            <Route exact path="/admin/" render={() => <p>Coming soon!</p>}/>
            <Route exact path="/admin/users" render={() => <p>Coming soon!</p>}/>
            <Route exact path="/admin/exercises" component={Exercises}/>
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
    padding: theme.spacing.unit * 3,
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