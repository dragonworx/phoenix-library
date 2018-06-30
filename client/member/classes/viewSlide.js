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
import fscreen from 'fscreen';

const styles = theme => ({
  root: {
    flexGrow: 1,
    height: '100%',
    zIndex: 1,
    overflow: 'hidden',
    position: 'relative',
    display: 'flex',
  },
});

// eslint-disable-next-line no-undef
const VERSION = PHOENIX_LIB_VERSION;

class ViewSlide extends React.Component {
  state = {
    cls: null,
    error: false,
  };

  async componentWillMount () {
    let classId;
    try {
      classId = JSON.parse(document.getElementById('phoenix-bundle').getAttribute('data-class-id'));
    } catch (e) {
      return this.setState({ error: true });
    }
    const { data: cls } = await axios.get(`/class/${classId}`);
    cls.program.forEach(category => category.durationSummary = category.exercises.reduce((duration, exercise) => duration += exercise.duration, 0));
    console.log(cls);
    this.setState({ cls });
  }

  render () {
    const { error, cls } = this.state;

    if (error) {
      return <h2>Class not found.</h2>;
    } else if (!cls) {
      return null;
    }

    return <p>{cls.name}</p>;
  }

  render2 () {alert(this.props.match.id);
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

export default withStyles(styles)(ViewSlide);