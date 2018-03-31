import React from 'react';
import AppBar from 'material-ui/AppBar';
import Tabs, { Tab } from 'material-ui/Tabs';
import Exercises from './exercises';
import { withStyles } from 'material-ui/styles';
import Badge from 'material-ui/Badge';
import axios from 'axios';

class TabsView extends React.Component {
  state = {
    exerciseCount: '.',
    value: 0,
  };

  async componentDidMount () {
    const { data: count } = await axios.get('/exercise/count');
    this.setState({ exerciseCount: count });
  }

  handleChange = (event, value) => {
    this.setState({ value });
  };

  render() {
    const { classes, isAdmin, isSuper, isDesigner } = this.props;
    const { value, exerciseCount } = this.state;

    return (
      <div className={classes.root}>
        <AppBar position="static">
          <Tabs value={value} onChange={this.handleChange}>
            <Tab label={<span>Exercises<Badge className={classes.margin} badgeContent={exerciseCount} color="secondary">&nbsp;</Badge></span>} />
            <Tab label="Classes" />
          </Tabs>
        </AppBar>
        {value === 0 && <Exercises isSuper={isSuper} isAdmin={isAdmin} isDesigner={isDesigner} />}
        {value === 1 && <p>Classes</p>}
      </div>
    );
  }
};

export default withStyles(theme => ({
  root: {
    flexGrow: 1,
    backgroundColor: theme.palette.background.paper,
  },
  margin: {
    margin: theme.spacing.unit * 2,
  },
}))(TabsView);