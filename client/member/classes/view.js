import React from 'react';
import Button from 'material-ui/Button';
import Paper from 'material-ui/Paper';
import Dialog, {
  DialogActions,
  DialogContent,
} from 'material-ui/Dialog';
import { FormLabel } from 'material-ui/Form';
import AppBar from 'material-ui/AppBar';
import Toolbar from 'material-ui/Toolbar';
import Chip from 'material-ui/Chip';
import Typography from 'material-ui/Typography';
import Grid from 'material-ui/Grid';
import Avatar from 'material-ui/Avatar';
import { withStyles } from "material-ui/styles";
import { multi } from '../../common/util';
import Checkbox from 'material-ui/Checkbox';
import { MenuItem } from 'material-ui/Menu';
import { ListItemText } from 'material-ui/List';
import { textToSprings } from '../exercises/grid';
import HamburgerMenu from '../../common/hamburgerMenu';
import classNames from 'classnames';
import { toOrdinal } from '../../common/util';
import axios from 'axios';

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
    padding: '10px 30px',
    paddingBottom: 50,
  },
  mins: {
    fontSize: '80%',
    opacity: 0.35,
    display: 'inline-block',
    marginLeft: 8,
  },
  ordinal: {
    fontSize: '80%',
    opacity: 0.5,
    display: 'inline-block',
  },
  revision: {
    fontSize: '70%',
    opacity: 0.5,
    display: 'inline-block',
    fontStyle: 'italic',
    position: 'absolute',
    right: 50,
    top: 23.
  },
  exerciseList: {
    padding: '0 63px',
  },
  classNotes: {
    fontSize: '80%',
    display: 'block',
    backgroundColor: '#f1faff',
    padding: 5,
    borderRadius: 5,
    marginTop: 5,
  },
  exerciseNotes: {
    fontSize: '70%',
    backgroundColor: '#f1faff',
    padding: 5,
    borderRadius: 5,
  },
  notesLabel: {
    fontSize: '65%',
    color: '#ccc',
    display: 'inline-block',
    textDecoration: 'underline',
    marginRight: 10,
  }
});

// eslint-disable-next-line no-undef
const VERSION = PHOENIX_LIB_VERSION;

const options = {
  showNotes: false,
};

const menuOptions = [
  (
    <MenuItem key="toggle_options" value='toggle_notes'>
      <Checkbox checked={options.showNotes} />
      <ListItemText primary={name} />
    </MenuItem>
  )
];

class ViewClass extends React.Component {
  state = {
    open: false,
    lightboxOpen: false
  };

  async componentWillMount () {
    const { viewItem } = this.props;
    const { data: program } = await axios.get(`/class/program/${viewItem.id}`);
    program.forEach(category => category.durationSummary = category.exercises.reduce((duration, exercise) => duration += exercise.duration, 0))
    viewItem.categories = program;
    this.setState({ open: true });
    
  }

  handleClose = () => {
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
    if (selectedValue === 'toggle_notes') {
      
    }
  };

  render () {
    const { viewItem, classes} = this.props;
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
                {name} <span className={classes.revision}>rev. {revision}</span> <span className={classes.mins}>{durationSummary} mins</span>
              </Typography>
              <HamburgerMenu showUser={false} className={classes.menu} options={menuOptions} onSelect={this.onUserMenuSelect} />
            </Toolbar>
          </AppBar>
          <DialogContent className={classes.content}>
          <span className={classes.notesLabel}>Notes:</span><span className={classes.classNotes} dangerouslySetInnerHTML={{__html: classNotes}}></span>
            {
              categories && categories.map((category, i) => {
                const categoryOrdinal = i + 1;
                return (
                  <div key={genreId + category.name + i}>
                    <h2><span className={classes.ordinal}>{categoryOrdinal + toOrdinal(categoryOrdinal)}.</span> {category.name} <span className={classes.mins}>{category.durationSummary} mins</span></h2>
                      <ul className={classes.exerciseList}>
                        {
                          category.exercises.map(exercise => {
                            return (
                              <li key={genreId + category.name + i + exercise.id}>
                                <h4>{exercise.repetitions} x {exercise.name} <span className={classes.mins}>{exercise.duration} mins</span></h4>
                                {
                                  exercise.notes ? <div><span className={classes.notesLabel}>Notes:</span><span className={classes.exerciseNotes} dangerouslySetInnerHTML={{__html: exercise.notes}}></span></div> : null
                                }
                              </li>
                            )
                          })
                        }
                      </ul>
                  </div>
                );
              })
            }
          </DialogContent>
          <footer className={classes.footer}>
            <span className={classes.footerHighlight}>v{VERSION}</span> | Phoenix Pilates Library &copy; 2018 All rights reserved | <a className={classes.footerHighlight} href="mailto:musicartscience@gmail.com?subject=Phoenix Pilates Library - Contact">Contact</a>
          </footer>
        </div>
      </Dialog>
    );
  }
}

export default withStyles(styles)(ViewClass);