import React from 'react';
import AppBar from 'material-ui/AppBar';
import Tabs, { Tab } from 'material-ui/Tabs';
import { withRouter } from 'react-router-dom';
import { withStyles } from 'material-ui/styles';
import Badge from 'material-ui/Badge';
import ExerciseIcon from 'material-ui-icons/Dns';
import ClassIcon from 'material-ui-icons/Assignment';
import UserIcon from 'material-ui-icons/Group';
import axios from 'axios';
import Exercises from './exercises';
import Classes from './classes';
import Users from './users';
import { permissions } from './session';

class TabsView extends React.Component {
  state = {
    exerciseCount: '...',
    classCount: '...',
    userCount: '...',
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
          userCount: response.data.users,
        });
      });
  }

  handleChange = (event, value) => {
    this.setState({ value });
  };

  render() {
    const { classes, isAdmin, showHeader } = this.props;
    const { value, exerciseCount, classCount, userCount } = this.state;

    const shouldShowHeader = isAdmin ? true : showHeader;

    const ExercisesTab = withRouter(
      ({ history }) => <Tab 
        style={{opacity: (isAdmin ? value === permissions.adminSections.EXERCISES : value === 0) ? 1 : 0.7}} 
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
        style={{ opacity: (isAdmin ? value === permissions.adminSections.CLASSES : value === 1) ? 1 : 0.7 }} 
        onClick={() => history.push(`${isAdmin ? '/admin/' : '/'}classes`)} 
        label={<span><ClassIcon 
        className={classes.icon} />Classes<Badge 
        className={classes.margin} 
        badgeContent={classCount} 
        color="primary" 
        classes={{ colorPrimary: classes.badge }}>&nbsp;</Badge></span>} 
      /> );

      const UsersTab = withRouter(
        ({ history }) => <Tab 
          style={{ opacity: (isAdmin ? value === permissions.adminSections.USERS : value === 2) ? 1 : 0.7 }} 
          onClick={() => history.push(`${isAdmin ? '/admin/' : '/'}users`)} 
          label={<span><UserIcon 
          className={classes.icon} />Users<Badge 
          className={classes.margin} 
          badgeContent={userCount} 
          color="primary" 
          classes={{ colorPrimary: classes.badge }}>&nbsp;</Badge></span>} 
        /> );

    return (
      <div className={classes.root}>
        {
          shouldShowHeader
          ? <AppBar position="static">
              <Tabs value={value} onChange={this.handleChange} classes={{ indicator: classes.indicator}}>
                {
                  isAdmin
                    ? [
                        permissions.canWriteExercise ? <ExercisesTab key="exerciseTab" /> : null,
                        permissions.canWriteClass ? <ClassesTab key="classesTab" /> : null,
                        permissions.canWriteUser ? <UsersTab key="userTab" /> : null
                      ]
                    : [
                        <ExercisesTab key="exerciseTab" />,
                        <ClassesTab key="classesTab" />
                      ]
                }
              </Tabs>
            </AppBar>
          : null
        }
        {
          isAdmin
            ? [
            value === permissions.adminSections.EXERCISES && <Exercises isAdmin={true} showHeader={true} key="exercises"  />,
            value === permissions.adminSections.CLASSES && <Classes isAdmin={true} showHeader={true} key="classes" />,
            value === permissions.adminSections.USERS && <Users isAdmin={true} showHeader={true} key="users" />
          ]
          : [
            value === 0 && <Exercises isAdmin={false} showHeader={showHeader} key="exercises"  />,
            value === 1 && <Classes isAdmin={false} showHeader={showHeader} key="classes" />,
          ]
        }
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