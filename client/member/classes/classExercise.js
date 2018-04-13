import React from 'react';
import { withStyles } from 'material-ui/styles';
import { ListItem } from 'material-ui/List';
import Avatar from 'material-ui/Avatar';
import ImageIcon from 'material-ui-icons/Image';
import UpIcon from 'material-ui-icons/ArrowUpward';
import DownIcon from 'material-ui-icons/ArrowDownward';
import RemoveIcon from 'material-ui-icons/Cancel';
import Select from 'material-ui/Select';
import IconButton from 'material-ui/IconButton';
import { FormControl } from 'material-ui/Form';
import { InputLabel } from 'material-ui/Input';
import { MenuItem } from 'material-ui/Menu';
import axios from 'axios';
import ViewExercise from '../exercises/view';
import { toOrdinal, combineCss } from '../../common/util';
import If from '../../common/if';

class ClassExercise extends React.Component {
  state = {
    viewItem: null,
    exercise: null,
    noteEditValue: null,
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
    this.props.onDurationChange(exercise);
    this.setState({ exercise });
  };

  handleNotesChange = (e, exercise) => {
    const html = e.target.innerHTML;
    exercise.notes = html;
    this.setState({ exercise });
  };

  handleNotesFocus = e => {
    this.setState({ noteEditValue: e.target.innerHTML });
  };

  handleNotesBlur = () => {
    this.setState({ noteEditValue: null });
  };

  onRemoveExercise = (exercise) => {
    const { category, onDeleteExercise } = this.props;
    const exercises = category.exercises;
    const index = exercises.indexOf(exercise);
    exercises.splice(index, 1);
    onDeleteExercise(exercise);
  };

  render () {
    const { viewItem, exercise, noteEditValue } = this.state;
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
          <p className={classes.listTextP} 
            contentEditable="true" 
            suppressContentEditableWarning={true} 
            onInput={e => this.handleNotesChange(e, exercise)}
            onFocus={this.handleNotesFocus}
            onBlur={this.handleNotesBlur}
            dangerouslySetInnerHTML={{__html: noteEditValue ? noteEditValue : exercise.notes}}
          />
        </div>
        <form className={classes.form} autoComplete="off">
          <FormControl className={classes.formControl}>
            <InputLabel>Reps.</InputLabel>
            <Select
              autoWidth={true}
              value={exercise.repetitions}
              onChange={e => this.handleRepsChange(e, exercise)}
              classes={{ selectMenu: classes.selectMenu, icon: classes.selectIcon }}
            >
              <MenuItem value={1}>1</MenuItem>
              <MenuItem value={2}>2</MenuItem>
              <MenuItem value={3}>3</MenuItem>
              <MenuItem value={4}>4</MenuItem>
              <MenuItem value={5}>5</MenuItem>
              <MenuItem value={6}>6</MenuItem>
              <MenuItem value={7}>7</MenuItem>
              <MenuItem value={8}>8</MenuItem>
              <MenuItem value={9}>9</MenuItem>
              <MenuItem value={10}>10</MenuItem>
            </Select>
          </FormControl>
          <FormControl className={classes.formControl}>
            <InputLabel>Dur.</InputLabel>
            <Select
              autoWidth={true}
              value={exercise.duration}
              onChange={e => this.handleDurationChange(e, exercise)}
              classes={{ selectMenu: classes.selectMenu2, icon: classes.selectIcon }}
            >
              <MenuItem value={1}>1 min</MenuItem>
              <MenuItem value={2}>2 min</MenuItem>
              <MenuItem value={3}>3 min</MenuItem>
              <MenuItem value={4}>4 min</MenuItem>
              <MenuItem value={5}>5 min</MenuItem>
              <MenuItem value={6}>6 min</MenuItem>
              <MenuItem value={7}>7 min</MenuItem>
              <MenuItem value={8}>8 min</MenuItem>
              <MenuItem value={9}>9 min</MenuItem>
              <MenuItem value={10}>10 min</MenuItem>
              <MenuItem value={15}>15 min</MenuItem>
              <MenuItem value={20}>20 min</MenuItem>
              <MenuItem value={30}>30 min</MenuItem>
            </Select>
          </FormControl>
        </form>
        <If test={hover === exercise.id}>
          <div className={classes.subToolbar}>
            <a title="move exercise up"><IconButton variant="fab" color="primary" aria-label="move up" className={classes.button} onClick={() => onMoveUpExercise(exercise)} disabled={exercise.index === 0}>
              <UpIcon />
            </IconButton></a>
            <a title="move exercise down"><IconButton variant="fab" color="primary" aria-label="move down" className={classes.button} onClick={() => onMoveDownExercise(exercise)} disabled={exercise.index === exercises.length - 1}>
              <DownIcon />
            </IconButton></a>
            <a title="remove exercise"><IconButton variant="fab" color="secondary" aria-label="remove category" className={classes.button} onClick={() => this.onRemoveExercise(exercise)}>
              <RemoveIcon />
            </IconButton></a>
          </div>
        </If>
        {
          viewItem ? <ViewExercise viewItem={viewItem} onClose={this.handleViewClose} /> : null
        }
      </ListItem>
    );
  }
}

export default withStyles(theme => ({
  form: {
    display: 'flex',
    flexWrap: 'wrap',
  },
  button: {
    // margin: theme.spacing.unit,
  },
  subToolbar: {
    position: "absolute",
    top: -7,
    right: 95,
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
    borderBottom: '1px dashed #e4e4e4',
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
    backgroundColor: '#f3fdff',
    padding: 3,
    borderRadius: 5,
    borderTop: '1px solid #b1cbdc',
    color: '#9ebacf',
  },
  formControl: {
    margin: 8,
    marginLeft: 5,
    width: 32,
  },
  selectMenu: {
    minWidth: 0,
    fontSize: '80%',
  },
  selectMenu2: {
    minWidth: 0,
    fontSize: '80%',
    width: 40,
  },
  selectIcon: {
    display: 'none',
  },
  title: {
    maxWidth: '80%'
  },
}))(ClassExercise);