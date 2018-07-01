import React from 'react';
import Dialog, {
  DialogContent,
} from 'material-ui/Dialog';
import AppBar from 'material-ui/AppBar';
import Toolbar from 'material-ui/Toolbar';
import Typography from 'material-ui/Typography';
import Avatar from 'material-ui/Avatar';
import { withStyles } from "material-ui/styles";
import CloseIcon from 'material-ui-icons/Input';
import classNames from 'classnames';
import axios from 'axios';
import HamburgerMenu from '../../common/hamburgerMenu';
import { toOrdinal, css, plural } from '../../common/util';
import ViewExercise from '../exercises/view';
// import fscreen from 'fscreen';

const styles = theme => ({
  root: {
    flexGrow: 1,
    height: '100%',
    zIndex: 1,
    overflow: 'hidden',
    position: 'relative',
    display: 'flex',
  },
  avatar: {
    margin: 10,
  },
  bigAvatar: {
    width: 48,
    height: 48,
  },
  appBar: {
    zIndex: theme.zIndex.drawer + 1,
    backgroundColor: 'orange'
  },
  footer: {
		width: '100%',
		color: '#989898',
		bottom: 0,
		height: 30,
		padding: 5,
		position: 'fixed',
		fontSize: '80%',
		boxSizing: 'border-box',
		textAlign: 'center',
		backgroundColor: 'rgba(44, 59, 76, 0.25)',
  },
  footerHighlight: {
    color: '#fff',
  },  appBar: {
    zIndex: theme.zIndex.drawer + 1,
    backgroundColor: '#4089ff'
  },
  menu: {
    position: 'absolute',
    right: 0,
  },
  content: {
    flexGrow: 1,
    backgroundColor: '#2e5594',
    background: 'linear-gradient(180deg, #ffffff 0, #dbf8ff 100%)',
    minWidth: 0, // So the Typography noWrap works
    display: 'flex',
    flexDirection: 'column',
    marginTop: 66,
    padding: '0 20px',
    paddingBottom: 50,
  },
  mins: {
    fontSize: '70%',
    color: '#5475af',
    display: 'inline-block',
    marginLeft: 5,
  },
  classMins: {
    fontSize: '80%',
    color: '#a4eeff',
    display: 'block',
    marginLeft: 0,
  },
  ordinal: {
    fontSize: '70%',
    opacity: 0.5,
    display: 'inline-block',
    minWidth: 35,
  },
  exerciseOrdinal: {
    opacity: 0.3,
    minWidth: 35,
  },
  reps: {
    color: '#459ae2',
    minWidth: 25,
    display: 'inline-block',
  },
  revision: {
    fontSize: '70%',
    opacity: 0.4,
    color: '#fff',
  },
  exerciseList: {
    padding: '0 55px',
    paddingRight: 0,
  },
  classNotes: {
    fontSize: '80%',
    display: 'block',
    backgroundColor: '#f1faff',
    padding: '0 5px',
    borderRadius: 5,
    marginTop: 10,
    border: '1px solid #ccc',
  },
  exerciseNotes: {
    fontSize: '70%',
    backgroundColor: '#f1faff',
    padding: 5,
    borderRadius: 5,
    border: '1px solid #ccc',
  },
  notesLabel: {
    fontSize: '65%',
    color: '#ccc',
    display: 'inline-block',
    textDecoration: 'underline',
    marginRight: 10,
  },
  exercise: {
    cursor: 'pointer',
    margin: '10px 0px',
  },
});

// eslint-disable-next-line no-undef
const VERSION = PHOENIX_LIB_VERSION;

const options = {
  showNotes: false,
  showDurations: true,
};

const menuOptions = [
  { 
    value: 'toggleNotes',
    label: 'Notes',
    isChecked: () => options.showNotes
  },
  { 
    value: 'toggleDurations',
    label: 'Durations',
    isChecked: () => options.showDurations
  },
  {
    value: 'close',
    label: 'Close',
    Icon: CloseIcon,
  }
];

class ViewList extends React.Component {
  state = {
    open: false,
    lightboxOpen: false,
    showNotes: options.showNotes,
    showDurations: options.showDurations,
    viewExercise: null,
  };

  async componentWillMount () {
    const { viewItem } = this.props;
    const { data: program } = await axios.get(`/class/program/${viewItem.id}`);
    program.forEach(category => category.durationSummary = category.exercises.reduce((duration, exercise) => duration += exercise.duration, 0));
    viewItem.categories = program;
    this.setState({ open: true });
  }

  handleClose = () => {
    try {
      // fscreen.exitFullscreen();
    } catch (e) {

    }
    this.setState({ open: false });
    this.props.onClose();
  };

  handleImgClose = () => {
    this.setState({ lightboxOpen: false });
  };

  handleImgClick = () => {
    this.setState({ lightboxOpen: true });
  };

  onUserMenuSelect = selectedValue => {
    if (selectedValue === 'toggleNotes') {
      options.showNotes = !options.showNotes;
    } else if (selectedValue === 'toggleDurations') {
      options.showDurations = !options.showDurations;
    } else if (selectedValue === 'close') {
      this.handleClose();
    }
    this.setState({ showNotes: options.showNotes, showDurations: options.showDurations });
  };

  onExerciseClick = exercise => {
    this.setState({ viewExercise: exercise });
  };

  onViewExerciseClose = () => {
    this.setState({ viewExercise: null });
  };

  render () {
    const { viewItem, classes} = this.props;
    const { showNotes, showDurations, viewExercise } = this.state;
    const { name, categories, genreId, durationSummary, revision, notes: classNotes } = viewItem;

    return (
      <Dialog
        fullScreen
        open={this.state.open}
        onClose={this.handleClose}
        aria-labelledby="form-dialog-title"
        maxWidth={false}
        disableEscapeKeyDown={false}
        disableBackdropClick={false}
        >
        <div className={classes.root}>
          <AppBar position="absolute" className={classes.appBar}>
            <Toolbar>
              <Avatar
                  alt={`Phoenix Pilates Courseware`}
                  src="/img/icon/48x48.png"
                  className={classNames(classes.avatar, classes.bigAvatar)}
                />
              <Typography variant="title" color="inherit" noWrap className={classes.name}>
                {name} <span className={classes.revision}>r{revision}</span> {
                showDurations
                  ? <span className={css(classes.mins, classes.classMins)}>{plural(durationSummary, 'min')}</span>
                  : null
              }
              </Typography>
              <HamburgerMenu showUser={false} className={classes.menu} options={menuOptions} onSelect={this.onUserMenuSelect} />
            </Toolbar>
          </AppBar>
          <DialogContent className={classes.content}>
            {
              showNotes && classNotes && classNotes.trim().length
                ? <span className={classes.classNotes} dangerouslySetInnerHTML={{__html: classNotes}}></span>
                : null
            }
            {
              categories && categories.map((category, i) => {
                const categoryOrdinal = i + 1;
                return (
                  <div key={genreId + category.name + i}>
                    <h3>
                      <span className={classes.ordinal}>{categoryOrdinal + toOrdinal(categoryOrdinal)}.</span> {category.name} {
                        showDurations
                          ? <span className={classes.mins}>{plural(category.durationSummary, 'min')}</span>
                          : null
                      }
                    </h3>
                    <ul className={classes.exerciseList}>
                      {
                        category.exercises.map((exercise, i) => {
                          const exerciseOrdinal = i + 1;
                          return (
                            <li key={genreId + category.name + i + exercise.id}>
                              <h4 className={classes.exercise} onClick={() => this.onExerciseClick(exercise)}>
                                <span className={css(classes.ordinal, classes.exerciseOrdinal)}>{exerciseOrdinal + toOrdinal(exerciseOrdinal)}.</span>
                                <span className={classes.reps}>{exercise.repetitions} x</span> {exercise.name} {
                                  showDurations
                                    ? <span className={classes.mins}>{plural(exercise.duration, 'min')}</span>
                                    : null
                                }
                              </h4>
                              {
                                showNotes && exercise.notes && exercise.notes.length ? <span className={classes.exerciseNotes} dangerouslySetInnerHTML={{__html: exercise.notes}}></span> : null
                              }
                            </li>
                          );
                        })
                      }
                    </ul>
                  </div>
                );
              })
            }
          </DialogContent>
          <footer className={classes.footer}>
            <span className={classes.footerHighlight}>v{VERSION}</span> | Phoenix Pilates &copy; 2018 | <a className={classes.footerHighlight} href="mailto:musicartscience@gmail.com?subject=Phoenix Pilates Library - Contact">Contact</a>
          </footer>
        </div>
        {
          viewExercise ? <ViewExercise viewItem={viewExercise} onClose={this.onViewExerciseClose} /> : null
        }
      </Dialog>
    );
  }
}

export default withStyles(styles)(ViewList);