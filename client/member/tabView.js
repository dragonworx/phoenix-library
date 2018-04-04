import React from 'react';
import AppBar from 'material-ui/AppBar';
import Tabs, { Tab } from 'material-ui/Tabs';
import { withRouter } from 'react-router-dom';
import { withStyles } from 'material-ui/styles';
import Badge from 'material-ui/Badge';
import axios from 'axios';
import Exercises from './exercises';
import Classes from './classes';
// import { permissions } from './session';

class TabsView extends React.Component {
  state = {
    exerciseCount: '...',
    classCount: '...',
    value: -1,
  };

  constructor (props) {
    super(props);
    this.state.value = props.value || 0;
  }

  componentDidMount () {
    axios.get('/counts')
      .then(response => {
        this.setState({
          exerciseCount: response.data.exercises,
          classCount: response.data.classes,
        });
      });
  }

  handleChange = (event, value) => {
    this.setState({ value });
  };

  render() {
    const { classes, readOnly } = this.props;
    const { value, exerciseCount, classCount } = this.state;

    const ExercisesTab = withRouter(({ history }) => <Tab style={{opacity:value === 0 ? 1 : 0.7}} onClick={() => history.push(`${!readOnly ? '/admin/' : '/'}exercises`)} label={<span>Exercises<Badge className={classes.margin} badgeContent={exerciseCount} color="secondary">&nbsp;</Badge></span>} /> );
    const ClassesTab = withRouter(({ history }) => <Tab style={{opacity:value === 1 ? 1 : 0.7}} onClick={() => history.push(`${!readOnly ? '/admin/' : '/'}classes`)} label={<span>Classes<Badge className={classes.margin} badgeContent={classCount} color="secondary">&nbsp;</Badge></span>} /> );

    return (
      <div className={classes.root}>
        <AppBar position="static">
          <Tabs value={value} onChange={this.handleChange}>
            <ExercisesTab />
            <ClassesTab />
          </Tabs>
        </AppBar>
        {value === 0 && <Exercises />}
        {value === 1 && <Classes />}
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