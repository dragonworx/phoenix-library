import React from "react";
import { withStyles } from 'material-ui/styles';
import Paper from "material-ui/Paper";
import Typography from "material-ui/Typography";
import UpIcon from "material-ui-icons/KeyboardArrowUp";
import DownIcon from "material-ui-icons/KeyboardArrowDown";
import AddIcon from "material-ui-icons/AddCircle";
import RemoveIcon from "material-ui-icons/Cancel";
import IconButton from "material-ui/IconButton";
import ExpandMoreIcon from 'material-ui-icons/ExpandMore';
import ExpansionPanel, {
  ExpansionPanelSummary,
  ExpansionPanelDetails,
} from 'material-ui/ExpansionPanel';
import axios from 'axios';
import SelectExercise from './selectExercises';
import { toOrdinal } from '../../common/util';

class Visible extends React.PureComponent {
  render () {
    const { show, children } = this.props;
    if (!show) {
      return null;
    }
    return <React.Fragment>{ children }</React.Fragment>;
  }
}

class ProgramGroup extends React.PureComponent {
  state = {
    showSelectExercise: false,
    selectableExercises: null,
  };

  onAddClick = async movementId => {
    const { genreId } = this.props;
    const { data: selectableExercises } = await axios.get(`/class/category/exercises/${genreId}/${movementId}`);
    this.setState({ showSelectExercise: true, selectableExercises });
  };

  handleCloseSelectExercise = exerciseIds => {
    if (exerciseIds) {
      const { category } = this.props;
      const exercises = this.state.selectableExercises.filter(exercise => exerciseIds.indexOf(exercise.id) > -1);
      category.exercises.push.apply(category.exercises, exercises);
    }
    this.setState({ showSelectExercise: false });
  };

  render() {
    const { showSelectExercise, selectableExercises } = this.state;
    const { classes, genreId, category, hasHover } = this.props;
    const { exercises } = category;
    const index = category.index + 1;
    const ord = toOrdinal(index);

    return (
      <Paper 
        id={`class-exercise-group-${genreId + '-' + category.labelId}`} 
        className={classes.root} elevation={4} 
        onMouseOver={this.onMouseOver} 
        onMouseOut={this.onMouseOut} 
        data-type="hover-item"
        hover-value={category.index}
      >
        <Typography variant="title" component="p">
          <span className={classes.ordinal}>{index}{ord}.</span> {category.name}
        </Typography>
        <ExpansionPanel>
          <ExpansionPanelSummary expandIcon={<ExpandMoreIcon />}>
            <Typography className={classes.heading}>{exercises.length} Exercise{exercises.length === 1 ? '' : 's'}</Typography>
          </ExpansionPanelSummary>
          <ExpansionPanelDetails>
          {
            exercises.map(exercise => <p key={exercise.name}>{exercise.name}</p>)
          }
          </ExpansionPanelDetails>
        </ExpansionPanel>
        <Visible show={hasHover}>
          <div className={classes.toolbar}>
            <IconButton variant="fab" color="primary" aria-label="add exercise" className={classes.button} onClick={() => this.onAddClick(category.labelId)}>
              <AddIcon />
            </IconButton>
            <IconButton variant="fab" color="primary" aria-label="move up" className={classes.button} onClick={() => this.onMoveUpClick(category.labelId)}>
              <UpIcon />
            </IconButton>
            <IconButton variant="fab" color="primary" aria-label="move down" className={classes.button} onClick={() => this.onMoveDownClick(category.labelId)}>
              <DownIcon />
            </IconButton>
            <IconButton variant="fab" color="primary" aria-label="remove category" className={classes.button} onClick={() => this.onRemoveClick(category.labelId)}>
              <RemoveIcon />
            </IconButton>
          </div>
        </Visible>
        <Visible show={showSelectExercise}>
          <SelectExercise
              open={true}
              onClose={this.handleCloseSelectExercise}
              exercises={selectableExercises}
            />
        </Visible>
      </Paper>
    );
  }
}

export default withStyles(theme => ({
  root: theme.mixins.gutters({
    paddingTop: 16,
    paddingBottom: 16,
    marginTop: theme.spacing.unit * 3,
    position: 'relative',
    borderRadius: 5,
  }),
  button: {
    // margin: theme.spacing.unit,
  },
  toolbar: {
    position: "absolute",
    right: 0,
    top: 5
  },
  ordinal: {
    color: '#aaa',
    fontSize: '80%'
  }
}))(ProgramGroup);
