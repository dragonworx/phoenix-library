import React from 'react';
import {
  BrowserRouter as Router,
  Route,
} from 'react-router-dom';
import PropTypes from 'prop-types';
import { withStyles } from 'material-ui/styles';
import Drawer from 'material-ui/Drawer';
import AppBar from 'material-ui/AppBar';
import Toolbar from 'material-ui/Toolbar';
import Typography from 'material-ui/Typography';
import SideNav from './sideNav';
import styles from './styles';
import { user } from '../common/session';
import Exercises from './exercises';

function Admin(props) {
  const { classes } = props;

  return (
    <Router>
      <div className={classes.root}>
        <AppBar position="absolute" className={classes.appBar}>
          <Toolbar>
            <Typography variant="title" color="inherit" noWrap>
              {`Welcome${user.last_login ? ' back' : ''} ${user.first_name}`}
            </Typography>
          </Toolbar>
        </AppBar>
        <Drawer
          variant="permanent"
          classes={{
            paper: classes.drawerPaper,
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

Admin.propTypes = {
  classes: PropTypes.object.isRequired,
};

export default withStyles(styles)(Admin);