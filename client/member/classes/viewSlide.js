import React from 'react';
import { withStyles } from "material-ui/styles";
import axios from 'axios';
import fscreen from 'fscreen';
import { clone } from '../../common/util';
import LinearProgress from 'material-ui/Progress/LinearProgress';
import { textToSprings } from '../exercises/grid';

const styles = theme => ({
  startRoot: {
    display: 'flex',
    flexDirection: 'column',
    alignItems: 'center',
    justifyContent: 'center',
    height: '100%',
  },
  exerciseRoot: {
    display: 'flex',
    flexDirection: 'column',
    alignItems: 'center',
    justifyContent: 'center',
    height: '100%',
  },
  className: {

  },
  exerciseName: {
    
  },
  exercisePhoto: {
    backgroundColor: 'rgb(242, 242, 242)',
    maxHeight: '80%',
    maxWidth: '80%',
    minHeight: '40%',
    minWidth: '60%',
    boxShadow: '0px 5px 15px 10px rgba(0,0,0,0.3)',
  },
  exerciseRepetitions: {

  },
  progress: {
    width: '100%',
    position: 'absolute',
    bottom: 0,
  },
  springsContainer: {
    position: 'absolute',
    top: 20,
    right: 20,
    fontSize: '200%',
  },
  colorPrimary: {
    backgroundColor: 'darkgreen',
  },
  barColorPrimary: {
    backgroundColor: 'lightgreen',
  }
});

// eslint-disable-next-line no-undef
// const VERSION = PHOENIX_LIB_VERSION;

const getParam = (name, shouldThrow) => {
  try {
    return JSON.parse(document.getElementById('phoenix-bundle').getAttribute(`data-${name}-id`));
  } catch (e) {
    if (shouldThrow) {
      throw e;
    }
    return null;
  }
};

class ViewSlide extends React.Component {
  state = {
    cls: null,
    exercises: [],
    index: -1,
    isClassNotFound: false,
    imageTimeout: false,
  };

  async componentWillMount () {
    let classId, isClassNotFound = false;
    try {
      classId = getParam('class', true);
    } catch (e) {
      isClassNotFound = true;
    }

    // const categoryIndex = getParam('category');
    // const exerciseIndex = getParam('exercise');

    const { data: cls } = await axios.get(`/class/${classId}`);
    const exercises = [];

    if (cls) {
      cls.program.forEach(category => {
        category.durationSummary = category.exercises.reduce((duration, exercise) => duration += exercise.duration, 0);
        category.exercises.forEach(exercise => {
          const exc = clone(exercise);
          exc.category = category;
          exercises.push(exc);
        });
      });
    } else {
      isClassNotFound = true;
    }

    this.setState({ isClassNotFound, cls, exercises });

    window.addEventListener('keyup', this.onWindowKeyUp);
    window.addEventListener('click', this.onWindowClick);
  }

  componentDidMount () {
    window.removeEventListener('keyup', this.onWindowKeyUp);
    window.removeEventListener('click', this.onWindowClick);
  }

  onWindowKeyUp = e => {
    const keyCode = e.keyCode;
    // 39, 40 =>
    // 37, 38 <=
    if (keyCode === 39) {
      this.nextSlide();
    } else if (keyCode === 37) {
      this.prevSlide();
    } else if (keyCode === 38) {
      this.startSlide();
    } else if (keyCode === 40) {
      this.endSlide();
    }
  };

  onWindowClick = () => {
    this.nextSlide();
  };

  nextSlide () {
    const index = Math.min(this.state.index + 1, this.state.exercises.length);
    if (index === 0) {
      try {
        fscreen.requestFullscreen(document.documentElement);
      } catch (e) {
  
      }
    }
    this.setState({ index });
  }

  prevSlide () {
    const index = Math.max(this.state.index - 1, -1);
    this.setState({ index });
  }

  startSlide () {
    this.setState({ index: -1 });
  }

  endSlide () {
    this.setState({ index: this.state.exercises.length });
  }

  render () {
    const { isClassNotFound, cls, exercises, index } = this.state;

    if (isClassNotFound) {
      return <h2>Class not found</h2>;
    } else if (!cls) {
      return null;
    }

    if (index === -1) {
      return this.renderStart();
    } else if (index === exercises.length) {
      return this.renderEnd();
    } else {
      return this.renderExercise();
    }
  }

  renderStart () {
    const { classes } = this.props;
    const { cls } = this.state;

    return (
      <div className={classes.startRoot}>
        <h1>{cls.name}</h1>
        <h2>{cls.durationSummary} mins</h2>
        <h3>
        Roll Down<br/>
        Check into your<br/>
        body and out of<br/>
        the world.  
      </h3>
      </div>
    );
  }

  renderEnd () {
    const { classes } = this.props;
    const { cls } = this.state;

    return (
      <div className={classes.startRoot}>
        <h1>{cls.name} Completed.</h1>
        <h3>
        Roll Down<br/>
        Check into the<br/>
        world. Stay in<br/>
        your body. 
        </h3>
      </div>
    );
  }

  renderExercise () {
    const { classes } = this.props;
    const { exercises, index } = this.state;

    const exercise = exercises[index];

    // eslint-disable-next-line no-undef
    const photoUrl = exercise.photo ? `${PHOENIX_LIB_STORAGE}${exercise.id}_1_full.png` : '/img/image-placeholder.png';

    return (
      <div className={classes.exerciseRoot}>
        <h1 className={classes.exerciseName}>{exercise.name}</h1>
        <img id="photo" className={classes.exercisePhoto} src={photoUrl} />
        <h2 className={classes.exerciseRepetitions}>x {exercise.repetitions}</h2>
        <LinearProgress className={classes.progress} variant="determinate" value={Math.round(((index + 1) / exercises.length) * 100)} classes={{ colorPrimary: classes.colorPrimary, barColorPrimary: classes.barColorPrimary }} />
        <div id="springs" className={classes.springsContainer}>
          { textToSprings(exercise.springs, 45, '#fff') }
        </div>
      </div>
    );
  }
}

export default withStyles(styles)(ViewSlide);