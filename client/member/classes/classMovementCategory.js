import React from 'react';
import { withStyles } from 'material-ui/styles';
import { ListItemText } from 'material-ui/List';
import UpIcon from 'material-ui-icons/ArrowUpward';
import DownIcon from 'material-ui-icons/ArrowDownward';
import AddIcon from 'material-ui-icons/AddCircle';
import RemoveIcon from 'material-ui-icons/Cancel';
import { CircularProgress } from 'material-ui/Progress';
import IconButton from 'material-ui/IconButton';
import ExpandMoreIcon from 'material-ui-icons/ExpandMore';
import ExpansionPanel, {
  ExpansionPanelSummary,
  ExpansionPanelDetails,
} from 'material-ui/ExpansionPanel';
import axios from 'axios';
import SelectExercise from './selectExercises';
import { toOrdinal } from '../../common/util';
import HoverGroup from '../../common/hover';
import ClassExercise from './classExercise';
import If from '../../common/if';

class ClassMovementCategory extends React.Component {
  state = {
    showSelectExercise: false,
    selectableExercises: null,
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
    const { category } = this.props;
    category.exercises.forEach((exercise, i) => exercise.index = i);
    this.setState({ category, loading: false });
  };

  handleCloseSelectExercise = exerciseIds => {
    const { category } = this.props;
    if (exerciseIds) {
      const exercises = this.state.selectableExercises.filter(exercise => exerciseIds.indexOf(exercise.id) > -1);
      category.exercises.push.apply(category.exercises, exercises);
      category.exercises.forEach((exercise, i) => exercise.index = i);
    }
    if (exerciseIds && exerciseIds.length) {
      category.expanded = true;
    }
    this.props.onDurationChange();
    this.setState({ showSelectExercise: false });
  };

  handleExpandClick = () => {
    this.props.category.expanded = !this.props.category.expanded;
    this.setState({ loading: false });
  };

  handleHoverRef = el => {
    this.hover = el;
  };

  onDurationChange = exercise => {
    const { category } = this.props;
    category.duration = category.exercises.reduce((duration, exercise) => duration += exercise.duration, 0);
    this.props.onDurationChange(exercise);
    category.expanded = true;
    this.setState({ loading: false });
  };

  render() {
    const { showSelectExercise, selectableExercises, loading } = this.state;
    const { classes, genreId, category, program, hasHover, onMoveUp, onMoveDown } = this.props;
    const { name, exercises, expanded } = category;
    const index = category.index + 1;
    const ord = toOrdinal(index);
    const duration = exercises.reduce((duration, exercise) => duration + exercise.duration, 0);

    return (
      <ExpansionPanel
        id={`class-exercise-group-${genreId + '-' + category.labelId}`} 
        className={classes.root}
        data-hover-type="item"
        data-hover-value={category.index}
        expanded={expanded}
        style={expanded ? { paddingBottom: 22 } : {}}
      >
        <ExpansionPanelSummary expandIcon={<a title="expand / collapse"><ExpandMoreIcon onClick={this.handleExpandClick} style={{ height: 50 }} /></a>} classes={{ expanded: classes.expanded }}>
          <ListItemText primary={
            <span style={{fontSize:'1.2rem'}}><span className={classes.ordinal}>{`${index}${ord}.`}</span>{name}<span className={classes.duration}>{duration === 0 ? 'Blank' : `${duration} mins`}</span></span>
          } />
          { loading ? <CircularProgress className={classes.progress} thickness={3} /> : null }
          <If test={hasHover}>
            <div className={classes.toolbar}>
              <a title="add exercises to category"><IconButton variant="fab" color="primary" aria-label="add exercise" className={classes.button} onClick={() => this.onAddExercisesClick(category)}>
                <AddIcon />
              </IconButton></a>
              <a title="move category up"><IconButton variant="fab" color="primary" aria-label="move up" className={classes.button} onClick={() => onMoveUp(category)} disabled={category.index === 0}>
                <UpIcon />
              </IconButton></a>
              <a title="move category down"><IconButton variant="fab" color="primary" aria-label="move down" className={classes.button} onClick={() => onMoveDown(category)} disabled={category.index === program.length - 1}>
                <DownIcon />
              </IconButton></a>
              <a title="remove category"><IconButton variant="fab" color="secondary" aria-label="remove category" className={classes.button} onClick={() => this.onRemoveCategoryClick(category)}>
                <RemoveIcon />
              </IconButton></a>
            </div>
          </If>
        </ExpansionPanelSummary>
        <ExpansionPanelDetails className={classes.details}>
          {
            exercises.length === 0
            ? <span className={classes.empty}>Add some exercises!</span>
            : <HoverGroup ref={this.handleHoverRef} render={
            hover => (
              <div>
                {
                  exercises.map(exercise =>
                    <ClassExercise 
                      key={category.index + exercise.index + exercise.name} 
                      exercise={exercise} 
                      hover={hover} 
                      category={category} 
                      onMoveUpExercise={this.onMoveUpExercise}
                      onMoveDownExercise={this.onMoveDownExercise}
                      onDeleteExercise={this.onDeleteExercise}
                      onDurationChange={this.onDurationChange}
                    />)
                }
              </div>
            )} />
          }
        </ExpansionPanelDetails>
        <If test={showSelectExercise}>
          <SelectExercise
              onClose={this.handleCloseSelectExercise}
              exercises={selectableExercises}
            />
        </If>
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
    top: -4,
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
    top: 5,
    left: -20,
  },
  empty: {
    color: '#d5d5d5',
  },
  duration: {
    marginLeft: 10,
    color: '#90c2d7',
    fontSize: '80%',
  },
  expanded: {
    height: 40,
    minHeight: 0,
  }
}))(ClassMovementCategory);
