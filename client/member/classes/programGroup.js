import React from "react";
import { withStyles } from 'material-ui/styles';
import { ListItem, ListItemText } from 'material-ui/List';
import Avatar from 'material-ui/Avatar';
import ImageIcon from 'material-ui-icons/Image';
import UpIcon from "material-ui-icons/KeyboardArrowUp";
import DownIcon from "material-ui-icons/KeyboardArrowDown";
import AddIcon from "material-ui-icons/AddCircle";
import EditIcon from "material-ui-icons/ModeEdit";
import RemoveIcon from "material-ui-icons/Cancel";
import Select from 'material-ui/Select';
import { CircularProgress } from 'material-ui/Progress';
import IconButton from "material-ui/IconButton";
import Button from "material-ui/Button";
import ExpandMoreIcon from 'material-ui-icons/ExpandMore';
import { FormControl, FormHelperText } from 'material-ui/Form';
import Input, { InputLabel } from 'material-ui/Input';
import { MenuItem } from 'material-ui/Menu';
import ExpansionPanel, {
  ExpansionPanelSummary,
  ExpansionPanelDetails,
} from 'material-ui/ExpansionPanel';
import axios from 'axios';
import SelectExercise from './selectExercises';
import { toOrdinal, combineCss } from '../../common/util';
import ViewExercise from '../exercises/view';
import HoverGroup from '../../common/hover';

class Visible extends React.Component {
  render () {
    const { show, children } = this.props;
    if (!show) {
      return null;
    }
    return <React.Fragment>{ children }</React.Fragment>;
  }
}

class ProgramGroup extends React.Component {
  state = {
    showSelectExercise: false,
    selectableExercises: null,
    expanded: false,
    loading: false,
    viewItem: null,
  };

  onAddClick = async (movementId) => {
    const { genreId } = this.props;
    this.setState({ loading: true });
    const { data: selectableExercises } = await axios.get(`/class/category/exercises/${genreId}/${movementId}`);
    this.setState({ showSelectExercise: true, selectableExercises, loading: false });
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

  handleExerciseClick = async exercise => {
    const { data: exerciseWithUsage } = await axios.post('/exercise/usage', {
      exercise
    });
    this.setState({
      viewItem: exerciseWithUsage
    });
  };

  handleViewClose = () => {
    this.setState({ viewItem: null });
  };

  handleHoverRef = el => {
    this.hover = el;
  };

  handleRepsChange = (e, exercise) => {
    exercise.repetitions = parseInt(e.target.value, 10);
    this.setState({ category: this.state.category });
  };

  handleDurationChange = (e, exercise) => {
    exercise.duration = parseInt(e.target.value, 10);
    this.setState({ category: this.state.category });
  };

  handleNotesChange = (e, exercise) => {
    const html = e.target.innerHTML;
    exercise.notes = html;
    this.setState({ category: this.state.category });
  };

  render() {
    const { showSelectExercise, selectableExercises, expanded, loading, viewItem } = this.state;
    const { classes, genreId, category, program, hasHover, onMoveUp, onMoveDown } = this.props;
    const { name, exercises, labelId } = category;
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
                  <IconButton variant="fab" color="primary" aria-label="add exercise" className={classes.button} onClick={() => this.onAddClick(labelId)}>
                    <AddIcon />
                  </IconButton>
                  <IconButton variant="fab" color="primary" aria-label="move up" className={classes.button} onClick={() => onMoveUp(category)} disabled={category.index === 0}>
                    <UpIcon />
                  </IconButton>
                  <IconButton variant="fab" color="primary" aria-label="move down" className={classes.button} onClick={() => onMoveDown(category)} disabled={category.index === program.length - 1}>
                    <DownIcon />
                  </IconButton>
                  <IconButton variant="fab" color="secondary" aria-label="remove category" className={classes.button} onClick={() => this.onRemoveClick(labelId)}>
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
                exercises.map((exercise, i) => {
                  // eslint-disable-next-line no-undef
                  const thumbnailUrl = `${PHOENIX_LIB_STORAGE}%_1_thumb.png`;
                  return (
                    <ListItem 
                      key={i + exercise.name}
                      className={classes.item}
                      style={i === exercises.length - 1 ? { marginBottom: 0, borderBottom: 'none', paddingBottom: 0 } : {}}
                      data-hover-type="item"
                      data-hover-value={exercise.id}
                    >
                      <Avatar onClick={() => this.handleExerciseClick(exercise)}>
                      {
                        exercise.photo
                        ? <img src={thumbnailUrl.replace('%', exercise.id)} />
                        : <ImageIcon />
                      }
                      </Avatar>
                      <div className={combineCss(classes.listTextContainer, classes.title)}>
                        <h3 className={classes.listTextH3}>
                          { exercise.name }
                        </h3>
                        <p className={classes.listTextP} contentEditable="true" suppressContentEditableWarning={true} onInput={e => this.handleNotesChange(e, exercise)}>
                          Notes...
                        </p>
                      </div>
                      <FormControl className={classes.formControl}>
                        <InputLabel htmlFor="age-simple">Reps.</InputLabel>
                        <Select
                          value={exercise.repetitions}
                          onChange={e => this.handleRepsChange(e, exercise)}
                          classes={{selectMenu: classes.selectMenu}}
                        >
                          <MenuItem value={1}>1</MenuItem>
                          <MenuItem value={3}>3</MenuItem>
                          <MenuItem value={5}>5</MenuItem>
                        </Select>
                      </FormControl>
                      <FormControl className={classes.formControl}>
                        <InputLabel htmlFor="age-simple">Dur.</InputLabel>
                        <Select
                          value={exercise.duration}
                          onChange={e => this.handleDurationChange(e, exercise)}
                          classes={{selectMenu: classes.selectMenu}}
                        >
                          <MenuItem value={1}>1</MenuItem>
                          <MenuItem value={3}>3</MenuItem>
                          <MenuItem value={5}>5</MenuItem>
                        </Select>
                      </FormControl>
                      <Visible show={hover === exercise.id}>
                        <div className={classes.subToolbar}>
                          <IconButton variant="fab" color="primary" aria-label="move up" className={classes.button} onClick={() => this.onMoveUpExercise(exercise)} disabled={exercise.index === 0}>
                            <UpIcon />
                          </IconButton>
                          <IconButton variant="fab" color="primary" aria-label="move down" className={classes.button} onClick={() => this.onMoveDownExercise(exercise)} disabled={exercise.index === exercises.length - 1}>
                            <DownIcon />
                          </IconButton>
                          <IconButton variant="fab" color="secondary" aria-label="remove category" className={classes.button} onClick={() => this.onRemoveClick(labelId)}>
                            <RemoveIcon />
                          </IconButton>
                        </div>
                      </Visible>
                    </ListItem>
                  );
                })
              }
            </div>
          )} />
        {
          viewItem ? <ViewExercise viewItem={viewItem} onClose={this.handleViewClose} /> : null
        }
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
  subToolbar: {
    position: "absolute",
    top: -14,
    right: 93,
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
  summary: {
    fontStyle: 'italic',
    color: '#6e9bce',
  },
  listTextContainer: {
    flex: '1 1 auto',
    padding: '0 16px',
    minWidth: 0,
  },
  listTextH3: {
    color: 'rgba(0, 0, 0, 0.87)',
    fontSize: '1rem',
    fontWeight: 400,
    fontFamily: '"Roboto", "Helvetica", "Arial", sans-serif',
    lineHeight: '1.5em',
    margin: 0,
  },
  listTextP: {
    fontSize: '0.875rem',
    fontWeight: 400,
    fontFamily: '"Roboto", "Helvetica", "Arial", sans-serif',
    lineGeight: '1.46429em',
    margin: 0,
    backgroundColor: '#f5f8f8',
    padding: 3,
    borderRadius: 5,
    borderTop: '1px solid #b1cbdc',
    color: '#a4c0d5',
  },
  badge: {
    marginLeft: 10,
    color: '#64c5d8',
  },
  formControl: {
    margin: 8,
    marginLeft: 5,
    width: 32,
  },
  title: {
    maxWidth: '80%'
  },
  selectMenu: {
    minWidth: 0,
  }
}))(ProgramGroup);
