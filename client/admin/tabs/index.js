import React from 'react';
import AppBar from 'material-ui/AppBar';
import Tabs, { Tab } from 'material-ui/Tabs';
import Exercises from '../exercises';
import { withStyles } from 'material-ui/styles';

class TabsView extends React.Component {
  state = {
    value: 0,
  };

  handleChange = (event, value) => {
    this.setState({ value });
  };

  render() {
    const { classes } = this.props;
    const { value } = this.state;

    return (
      <div className={classes.root}>
        <AppBar position="static">
          <Tabs value={value} onChange={this.handleChange}>
            <Tab label="Exercises" />
            <Tab label="Classes" />
          </Tabs>
        </AppBar>
        {value === 0 && <Exercises />}
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
}))(TabsView);