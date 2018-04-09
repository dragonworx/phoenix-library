import React from "react";
import { withStyles } from 'material-ui/styles';
import { ListItem } from 'material-ui/List';
import Avatar from 'material-ui/Avatar';
import ImageIcon from 'material-ui-icons/Image';
import UpIcon from "material-ui-icons/KeyboardArrowUp";
import DownIcon from "material-ui-icons/KeyboardArrowDown";
import RemoveIcon from "material-ui-icons/Cancel";
import Select from 'material-ui/Select';
import IconButton from "material-ui/IconButton";
import { FormControl } from 'material-ui/Form';
import axios from 'axios';
import { InputLabel } from 'material-ui/Input';
import ViewExercise from '../exercises/view';
import { MenuItem } from 'material-ui/Menu';
import { toOrdinal, combineCss } from '../../common/util';
import Visible from '../../common/visible';

class ProgramExercise extends React.Component {
  state = {
    viewItem: null,
    exercise: null,
  };

  constructor (props) {
    super(props);
    this.state.exercise = props.exercise;
  }

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

  handleRepsChange = (e, exercise) => {
    exercise.repetitions = parseInt(e.target.value, 10);
    this.setState({ exercise });
  };

  handleDurationChange = (e, exercise) => {
    exercise.duration = parseInt(e.target.value, 10);
    this.setState({ exercise });
  };

  handleNotesChange = (e, exercise) => {
    const html = e.target.innerHTML;
    exercise.notes = html;
    this.setState({ exercise });
  };

  onRemoveExercise = (exercise) => {
    const { category, onDeleteExercise } = this.props;
    const exercises = category.exercises;
    const index = exercises.indexOf(exercise);
    exercises.splice(index, 1);
    onDeleteExercise(exercise);
  };

  render () {
    const { viewItem, exercise } = this.state;
    const { classes, hover, category, onMoveUpExercise, onMoveDownExercise } = this.props;
    const { exercises } = category;
    // eslint-disable-next-line no-undef
    const thumbnailUrl = `${PHOENIX_LIB_STORAGE}%_1_thumb.png`;
    const { index: i } = exercise;

    return (
      <ListItem 
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
            <span className={classes.ordinal}>{exercise.index + 1}{toOrdinal(exercise.index + 1)}</span>{ exercise.name }
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
          <InputLabel htmlFor="age-simple">Dur.<i>mins</i></InputLabel>
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
            <IconButton variant="fab" color="primary" aria-label="move up" className={classes.button} onClick={() => onMoveUpExercise(exercise)} disabled={exercise.index === 0}>
              <UpIcon />
            </IconButton>
            <IconButton variant="fab" color="primary" aria-label="move down" className={classes.button} onClick={() => onMoveDownExercise(exercise)} disabled={exercise.index === exercises.length - 1}>
              <DownIcon />
            </IconButton>
            <IconButton variant="fab" color="secondary" aria-label="remove category" className={classes.button} onClick={() => this.onRemoveExercise(exercise)}>
              <RemoveIcon />
            </IconButton>
          </div>
        </Visible>
        {
          viewItem ? <ViewExercise viewItem={viewItem} onClose={this.handleViewClose} /> : null
        }
      </ListItem>
    );
  }
}

export default withStyles(theme => ({
  button: {
    // margin: theme.spacing.unit,
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
  item: {
    cursor: 'pointer',
    padding: 0,
    paddingBottom: theme.spacing.unit,
    marginBottom: theme.spacing.unit,
    borderBottom: '1px dashed #ccc',
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
  formControl: {
    margin: 8,
    marginLeft: 5,
    width: 32,
  },
  selectMenu: {
    minWidth: 0,
  },
  title: {
    maxWidth: '80%'
  },
}))(ProgramExercise);