import React from "react";
import { withStyles } from 'material-ui/styles';
import { ListItem, ListItemText } from 'material-ui/List';
import Avatar from 'material-ui/Avatar';
import ImageIcon from 'material-ui-icons/Image';
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
import ViewExercise from '../exercises/view';

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

  handleCloseSelectExercise = exerciseIds => {
    if (exerciseIds && exerciseIds.length) {
      const { category } = this.props;
      const exercises = this.state.selectableExercises.filter(exercise => exerciseIds.indexOf(exercise.id) > -1);
      category.exercises.push.apply(category.exercises, exercises);
    }
    this.setState({ expanded: true && !!(exerciseIds && exerciseIds.length), showSelectExercise: false });
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
        data-type="hover-item"
        hover-value={category.index}
        expanded={expanded}
      >
        <ExpansionPanelSummary expandIcon={<ExpandMoreIcon onClick={this.handleExpandClick} />}>
              <ListItemText primary={<span><span className={classes.ordinal}>{`${index}${ord}.`}</span>{name}</span>} secondary={<span className={classes.summary}>{exercises.length === 0 ? 'Empty' : `${exercises.length} Exercise${exercises.length === 1 ? '' : 's'}`}</span>} />
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
                  <IconButton variant="fab" color="primary" aria-label="remove category" className={classes.button} onClick={() => this.onRemoveClick(labelId)}>
                    <RemoveIcon />
                  </IconButton>
                </div>
              </Visible>
        </ExpansionPanelSummary>
        <ExpansionPanelDetails className={classes.details}>
        {
          exercises.map((exercise, i) => {
            // eslint-disable-next-line no-undef
            const thumbnailUrl = `${PHOENIX_LIB_STORAGE}%_1_thumb.png`;
            return (
              <ListItem key={i + exercise.name} className={classes.item} onClick={() => this.handleExerciseClick(exercise)}>
                  <Avatar>
                  {
                    exercise.photo
                    ? <img src={thumbnailUrl.replace('%', exercise.id)} />
                    : <ImageIcon />
                  }
                  </Avatar>
                  <ListItemText primary={exercise.name} />
                </ListItem>
            );
          })
        }
        {
          viewItem ? <ViewExercise viewItem={viewItem} onClose={this.handleViewClose} /> : null
        }
        </ExpansionPanelDetails>
        <Visible show={showSelectExercise}>
          <SelectExercise
              open={true}
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
  }),
  button: {
    // margin: theme.spacing.unit,
  },
  toolbar: {
    position: "absolute",
    right: 28,
    top: 11
  },
  ordinal: {
    color: '#aaa',
    fontSize: '80%',
    display: 'inline-block',
    marginRight: 10,
  },
  details: {
    display: 'block'
  },
  item: {
    cursor: 'pointer',
    padding: 0,
    marginBottom: theme.spacing.unit * 2
  },
  progress: {
    position: 'absolute',
    top: 15,
    left: -20,
  },
  summary: {
    fontStyle: 'italic',
  }
}))(ProgramGroup);
