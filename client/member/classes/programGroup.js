import React from "react";
import { withStyles } from 'material-ui/styles';
import { ListItem, ListItemText } from 'material-ui/List';
import Avatar from 'material-ui/Avatar';
import ImageIcon from 'material-ui-icons/Image';
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
    expanded: false,
  };

  onAddClick = async (e, movementId) => {
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
    this.setState({ expanded: true, showSelectExercise: false });
  };

  handleExpandClick = () => {
    this.setState({ expanded: !this.state.expanded });
  };

  render() {
    const { showSelectExercise, selectableExercises, expanded } = this.state;
    const { classes, genreId, category, hasHover } = this.props;
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
              <ListItemText primary={`${index}${ord}. ${name}`} secondary={exercises.length === 0 ? 'Empty' : `${exercises.length} Exercise${exercises.length === 1 ? '' : 's'}`} />
              <Visible show={hasHover}>
                <div className={classes.toolbar}>
                  <IconButton variant="fab" color="primary" aria-label="add exercise" className={classes.button} onClick={e => this.onAddClick(e, labelId)}>
                    <AddIcon />
                  </IconButton>
                  <IconButton variant="fab" color="primary" aria-label="move up" className={classes.button} onClick={() => this.onMoveUpClick(labelId)}>
                    <UpIcon />
                  </IconButton>
                  <IconButton variant="fab" color="primary" aria-label="move down" className={classes.button} onClick={() => this.onMoveDownClick(labelId)}>
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
              <ListItem key={i + exercise.name} className={classes.item}>
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
    fontSize: '80%'
  },
  details: {
    display: 'block'
  },
  item: {
    cursor: 'pointer',
    padding: 0,
    marginBottom: theme.spacing.unit * 2
  },
}))(ProgramGroup);
