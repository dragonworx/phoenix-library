import React from "react";
import { withStyles } from 'material-ui/styles';
import Paper from "material-ui/Paper";
import Typography from "material-ui/Typography";
import UpIcon from "material-ui-icons/KeyboardArrowUp";
import DownIcon from "material-ui-icons/KeyboardArrowDown";
import AddIcon from "material-ui-icons/AddCircle";
import RemoveIcon from "material-ui-icons/Cancel";
import IconButton from "material-ui/IconButton";
// import Tooltip from "material-ui/Tooltip";
import axios from 'axios';
import SelectExercise from './selectExercises';

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
    const { classes, genreId, category, hover } = this.props;
    const index = category.index + 1;
    
    const s = String(index),
      len = s.length,
      end  = s.substr(len - 1, 1),
      teen = len > 1 && s.substr(len - 2, 1) === '1';
    let ord = 'th';

    if (end === "1" && !teen) {
      ord = "st";
    } else if (end === "2" && !teen) {
      ord = "nd";
    } else if (end === "3" && !teen) {
      ord = "rd";
    }

    return (
      <Paper 
        id={`class-exercise-group-${genreId + '-' + category.labelId}`} 
        className={classes.root} elevation={4} 
        onMouseOver={this.onMouseOver} 
        onMouseOut={this.onMouseOut} 
        data-type="program-group"
        data-index={category.index}
      >
        <Typography variant="title" component="p">
          {index}{ord}. {category.name}
        </Typography>
        {
          category.exercises.map(exercise => <p key={exercise.id}>{exercise.name}</p>)
        }
        <Visible show={hover === category.index}>
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
  }
}))(ProgramGroup);
