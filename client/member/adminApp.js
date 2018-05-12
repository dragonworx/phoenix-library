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
import LogoutIcon from 'material-ui-icons/PowerSettingsNew';
import HamburgerMenu from '../common/hamburgerMenu';
import { user, permissions } from './session';

// eslint-disable-next-line no-undef
const VERSION = PHOENIX_LIB_VERSION;
const logoutMenuItem = { value: 'Logout', label: <span key="logout"><LogoutIcon style={{ verticalAlign: 'bottom', marginRight: 10 }} /> Logout</span> };
const drawerWidth = 180;

class MemberApp extends React.PureComponent {
  state = {};

  onUserMenuSelect = selectedValue => {
    if (selectedValue === 'Logout') {
      location = '/logout';
    }
  };

  render () {
    const { classes } = this.props;
    const menuOptions = [ logoutMenuItem ];

    return (
      <Router>
        <div className={classes.root}>
          <AppBar position="absolute" className={classes.appBar}>
            <Toolbar>
              <a href="/">
                <Avatar
                  alt={`${user.firstName} ${user.lastName}`}
                  src="/img/icon/48x48.png"
                  className={classNames(classes.avatar, classes.bigAvatar)}
                />
              </a>
              <Typography variant="title" color="inherit" noWrap className={classes.titleContainer}>
                <div className={classes.titleMain}>Phoenix Pilates</div>
                <div className={classes.titleSub}>Exercise &amp; Class Library</div>
              </Typography>
              <HamburgerMenu isAdmin={true} className={classes.menu} options={menuOptions} onSelect={this.onUserMenuSelect} />
            </Toolbar>
            <PingStatus />
          </AppBar>
          <main className={classes.content}>
            <div className={classes.toolbar} />
            <Route exact path="/admin" component={() => <TabsView isAdmin={true} value={0} />}/>
            <Route exact path="/admin/exercises" component={() => <TabsView isAdmin={true} value={permissions.adminSections.EXERCISES} />}/>
            <Route exact path="/admin/classes" component={() => <TabsView  isAdmin={true} value={permissions.adminSections.CLASSES} />}/>
          </main>
          <footer className={classes.footer}>
          <span className={classes.footerHighlight}>v{VERSION}</span> | Phoenix Pilates Library &copy; 2018 All rights reserved | <a className={classes.footerHighlight} href="mailto:musicartscience@gmail.com?subject=Phoenix Pilates Library - Contact">Contact</a>
          </footer>
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
    backgroundColor: '#4089ff'
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
    backgroundColor: '#2e5594',
    background: 'linear-gradient(180deg, #2e5594 0, #000 100%)',
    minWidth: 0, // So the Typography noWrap works
    display: 'flex',
    paddingTop: 66,
    alignItems: 'flex-start',
    justifyContent: 'center',
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
  },
  footer: {
		width: '100%',
		color: '#989898',
		bottom: 0,
		height: 30,
		padding: 5,
		position: 'fixed',
		fontSize: '80%',
		boxSizing: 'border-box',
		textAlign: 'center',
		backgroundColor: 'rgba(44, 59, 76, 0.5)',
  },
  titleContainer: {
    position: 'relative',
    top: 1,
    left: 8,
  },
  titleMain: {

  },
  titleSub: {
    fontSize: '65%',
    color: '#e5e5e5',
  },
  footerHighlight: {
    color: '#fff',
  },
}))(MemberApp);