import React from "react";
import { withStyles } from 'material-ui/styles';
import { ListItemText } from 'material-ui/List';
import UpIcon from "material-ui-icons/KeyboardArrowUp";
import DownIcon from "material-ui-icons/KeyboardArrowDown";
import AddIcon from "material-ui-icons/AddCircle";
import RemoveIcon from "material-ui-icons/Cancel";
import { CircularProgress } from 'material-ui/Progress';
import IconButton from "material-ui/IconButton";
import ExpandMoreIcon from 'material-ui-icons/ExpandMore';
import ExpansionPanel, {
  ExpansionPanelSummary,
  ExpansionPanelDetails,
} from 'material-ui/ExpansionPanel';
import axios from 'axios';
import SelectExercise from './selectExercises';
import { toOrdinal } from '../../common/util';
import HoverGroup from '../../common/hover';
import ProgramExercise from './programExercise';
import Visible from '../../common/visible';

class ProgramGroup extends React.Component {
  state = {
    showSelectExercise: false,
    selectableExercises: null,
    expanded: false,
    loading: false,
  };

  onAddExercisesClick = async category => {
    const { genreId } = this.props;
    this.setState({ loading: true });
    const { data: selectableExercises } = await axios.get(`/class/category/exercises/${genreId}/${category.labelId}`);
    this.setState({ showSelectExercise: true, selectableExercises, loading: false });
  };

  onRemoveCategoryClick = category => {
    const { program, onDeleteCategory } = this.props;
    const index = program.indexOf(category);
    program.splice(index, 1);
    onDeleteCategory(category);
  };

  onMoveUpExercise = exercise => {
    const { category } = this.props;
    const { exercises } = category;
    const index = exercises.indexOf(exercise);
    exercises.splice(index, 1);
    exercises.splice(index - 1, 0, exercise);
    exercises.forEach((exercise, i) => exercise.index = i);
    this.setState({ category }, () => this.hover.setState({ hover: exercise.index }));
  };

  onMoveDownExercise = exercise => {
    const { category } = this.props;
    const { exercises } = category;
    const index = exercises.indexOf(exercise);
    exercises.splice(index, 1);
    exercises.splice(index + 1, 0, exercise);
    exercises.forEach((exercise, i) => exercise.index = i);
    this.hover.setState({ hover: exercise.index });
    this.setState({ category }, () => this.hover.setState({ hover: exercise.index }));
  };

  onDeleteExercise = () => {
    this.setState({ loading: false });
  };

  handleCloseSelectExercise = exerciseIds => {
    if (exerciseIds) {
      const { category } = this.props;
      const exercises = this.state.selectableExercises.filter(exercise => exerciseIds.indexOf(exercise.id) > -1);
      category.exercises.push.apply(category.exercises, exercises);
    }
    let expanded = this.state.expanded;
    if (exerciseIds && exerciseIds.length) {
      expanded = true;
    }
    this.setState({ expanded: expanded, showSelectExercise: false });
  };

  handleExpandClick = () => {
    this.setState({ expanded: !this.state.expanded });
  };

  handleHoverRef = el => {
    this.hover = el;
  };

  render() {
    const { showSelectExercise, selectableExercises, expanded, loading } = this.state;
    const { classes, genreId, category, program, hasHover, onMoveUp, onMoveDown } = this.props;
    const { name, exercises } = category;
    const index = category.index + 1;
    const ord = toOrdinal(index);

    return (
      <ExpansionPanel
        id={`class-exercise-group-${genreId + '-' + category.labelId}`} 
        className={classes.root}
        data-hover-type="item"
        data-hover-value={category.index}
        expanded={expanded}
        style={expanded ? { paddingBottom: 32 } : {}}
      >
        <ExpansionPanelSummary expandIcon={<ExpandMoreIcon onClick={this.handleExpandClick} style={{minHeight: 50}} />}>
              <ListItemText primary={<span style={{fontSize:'1.2rem'}}><span className={classes.ordinal}>{`${index}${ord}.`}</span>{name}</span>} />
              {
                loading ? <CircularProgress className={classes.progress} thickness={7} /> : null
              }
              <Visible show={hasHover}>
                <div className={classes.toolbar}>
                  <IconButton variant="fab" color="primary" aria-label="add exercise" className={classes.button} onClick={() => this.onAddExercisesClick(category)}>
                    <AddIcon />
                  </IconButton>
                  <IconButton variant="fab" color="primary" aria-label="move up" className={classes.button} onClick={() => onMoveUp(category)} disabled={category.index === 0}>
                    <UpIcon />
                  </IconButton>
                  <IconButton variant="fab" color="primary" aria-label="move down" className={classes.button} onClick={() => onMoveDown(category)} disabled={category.index === program.length - 1}>
                    <DownIcon />
                  </IconButton>
                  <IconButton variant="fab" color="secondary" aria-label="remove category" className={classes.button} onClick={() => this.onRemoveCategoryClick(category)}>
                    <RemoveIcon />
                  </IconButton>
                </div>
              </Visible>
        </ExpansionPanelSummary>
        <ExpansionPanelDetails className={classes.details}>
        <HoverGroup ref={this.handleHoverRef} render={
          hover => (
            <div>
              {
                exercises.map(exercise =>
                <ProgramExercise 
                  key={category.index + exercise.index + exercise.name} 
                  exercise={exercise} 
                  hover={hover} 
                  category={category} 
                  onMoveUpExercise={this.onMoveUpExercise}
                  onMoveDownExercise={this.onMoveDownExercise}
                  onDeleteExercise={this.onDeleteExercise}
                />)
              }
            </div>
          )} />
        </ExpansionPanelDetails>
        <Visible show={showSelectExercise}>
          <SelectExercise
              onClose={this.handleCloseSelectExercise}
              exercises={selectableExercises}
            />
        </Visible>
      </ExpansionPanel>
    );
  }
}

export default withStyles(theme => ({
  root: theme.mixins.gutters({
    marginBottom: theme.spacing.unit,
    position: 'relative',
    borderRadius: 5,
    cursor: 'default',
    paddingLeft: 0,
    paddingRight: 0,
  }),
  button: {
    // margin: theme.spacing.unit,
  },
  toolbar: {
    position: "absolute",
    right: 28,
    top: 1
  },
  ordinal: {
    color: '#375ace',
    fontSize: '80%',
    display: 'inline-block',
    marginRight: 10,
  },
  details: {
    display: 'block',
    backgroundColor: '#fbfdff',
    borderRadius: 10,
    padding: 10,
    border: '1px solid #eee',
  },
  item: {
    cursor: 'pointer',
    padding: 0,
    paddingBottom: theme.spacing.unit,
    marginBottom: theme.spacing.unit,
    borderBottom: '1px dashed #ccc',
  },
  progress: {
    position: 'absolute',
    top: 15,
    left: -20,
  },
}))(ProgramGroup);
