import React from 'react';
import AppBar from 'material-ui/AppBar';
import Tabs, { Tab } from 'material-ui/Tabs';
import { withRouter } from 'react-router-dom';
import { withStyles } from 'material-ui/styles';
import Badge from 'material-ui/Badge';
import ExerciseIcon from 'material-ui-icons/Dns';
import ClassIcon from 'material-ui-icons/Assignment';
import axios from 'axios';
import Exercises from './exercises';
import Classes from './classes';
import { permissions } from './session';

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
    const { classes, isAdmin } = this.props;
    const { value, exerciseCount, classCount } = this.state;

    const ExercisesTab = withRouter(
      ({ history }) => <Tab 
        style={{opacity:value === 0 ? 1 : 0.7}} 
        onClick={() => history.push(`${isAdmin ? '/admin/' : '/'}exercises`)} 
        label={<span><ExerciseIcon 
        className={classes.icon} />Exercises<Badge 
        className={classes.margin} 
        badgeContent={exerciseCount} 
        color="primary" 
        classes={{ colorPrimary: classes.badge }}>&nbsp;</Badge></span>} 
      /> );

    const ClassesTab = withRouter(
      ({ history }) => <Tab 
        style={{ opacity: value === 1 ? 1 : 0.7 }} 
        onClick={() => history.push(`${isAdmin ? '/admin/' : '/'}classes`)} 
        label={<span><ClassIcon 
        className={classes.icon} />Classes<Badge 
        className={classes.margin} 
        badgeContent={classCount} 
        color="primary" 
        classes={{ colorPrimary: classes.badge }}>&nbsp;</Badge></span>} 
      /> );

    return (
      <div className={classes.root}>
        <AppBar position="static">
          <Tabs value={value} onChange={this.handleChange} classes={{ indicator: classes.indicator}}>
            { isAdmin && permissions.isExerciseReadOnly ? null : <ExercisesTab /> }
            { isAdmin && permissions.isClassReadOnly ? null : <ClassesTab /> }
          </Tabs>
        </AppBar>
        {value === permissions.adminSections.EXERCISES && <Exercises isAdmin={isAdmin} />}
        {value === permissions.adminSections.CLASSES && <Classes isAdmin={isAdmin} />}
      </div>
    );
  }
};

export default withStyles(theme => ({
  root: {
    flexGrow: 1,
		margin: '15px 10px',
    borderRadius: 5,
    maxWidth: '98%',
  },
  margin: {
    margin: theme.spacing.unit * 2,
  },
  icon: {
		position: 'relative',
		top: 5,
		left: -7,
  },
  badge: {
    backgroundColor: '#f6bf18',
  },
  indicator: {
    backgroundColor: '#fff',
  }
}))(TabsView);