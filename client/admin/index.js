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
import ListMenu from './listMenu';
import styles from './styles';
import { user } from '../common/session';

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
        <ListMenu />
      </Drawer>
      <main className={classes.content}>
        <div className={classes.toolbar} />
        <Route exact path="/admin/" render={() => <p>home!</p>}/>
        <Route path="/admin/users" render={() => <p>users!</p>}/>
        <Route path="/admin/exercises" render={() => <p>exercises!</p>}/>
      </main>
    </div>
    </Router>
  );
}

Admin.propTypes = {
  classes: PropTypes.object.isRequired,
};

export default withStyles(styles)(Admin);