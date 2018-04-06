import React from 'react';
import Button from 'material-ui/Button';
import Paper from 'material-ui/Paper';
import FolderIcon from 'material-ui-icons/Folder';
import CheckIcon from 'material-ui-icons/Done';
import Dialog, {
  DialogActions,
  DialogContent,
} from 'material-ui/Dialog';
import List, {
  ListItem,
  ListItemIcon,
  ListItemSecondaryAction,
  ListItemText,
} from 'material-ui/List';
import { FormLabel } from 'material-ui/Form';
import AppBar from 'material-ui/AppBar';
import Chip from 'material-ui/Chip';
import Typography from 'material-ui/Typography';
import Grid from 'material-ui/Grid';
import { withStyles } from "material-ui/styles";
import { multi } from '../../common/util';
import Lightbox from '../../common/lightbox';
import { textToSprings } from '../exercises/grid';
import axios from 'axios';

class ViewExercise extends React.Component {
  state = {
    open: false,
    lightboxOpen: false,
    labels: null,
  };

  async componentWillMount () {
    const { data: labels } = await axios.get('/labels/get');
    const labelsById = {};
    labels.forEach(label => labelsById[label.id] = label);
    this.setState({ open: true, labels: labelsById });
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

  render () {
    const { viewItem, classes } = this.props;
    const { lightboxOpen } = this.state;
    // eslint-disable-next-line no-undef
    const photoUrl = `${PHOENIX_LIB_STORAGE}${viewItem.id}_1_full.png`;

    return (
      <div>
        <Dialog
          open={this.state.open}
          onClose={this.handleClose}
          aria-labelledby="form-dialog-title"
          maxWidth={false}
          disableEscapeKeyDown={false}
          disableBackdropClick={false}
          >
          <AppBar position="static">
            <Typography variant="title" color="inherit" className={classes.flex}>
              {viewItem.name.trim()}
            </Typography>
          </AppBar>
          { this.renderContent() }
        </Dialog>
        {
          lightboxOpen ? <Lightbox name={viewItem.photo} src={photoUrl} onClose={this.handleImgClose} /> : null
        }
      </div>
    );
  }

  renderContent () {
    const { labels } = this.state;
    const { classes, viewItem } = this.props;

    // eslint-disable-next-line no-undef
    const photoUrl = viewItem.photo ? `${PHOENIX_LIB_STORAGE}${viewItem.id}_1_preview.png` : '/img/image-placeholder.png';

    // const genres = viewItem.genre.map(genre => <Chip key={`genre_${genre}`} label={genre} className={multi(classes.chip, classes.genre)} />);
    // const movements = viewItem.movement.map(movement => <Chip key={`movement_${movement}`} label={movement} className={multi(classes.chip, classes.movement)} />);

    const categorisation = [];
    if (labels) {
      const usage = viewItem.usage;
    
      for (let genreId in usage) {
        const genreName = labels[genreId].name;
        categorisation.push((
          <Chip key={`genre_${genreId}`} label={genreName} className={multi(classes.chip, classes.genre)} classes={{ root: classes.chipRoot}} />
        ));
        
        const categories = usage[genreId];
        for (let movementId in categories) {
          const movementName = labels[movementId].name;
          categorisation.push((
            <Chip key={`movement_${genreId}_${movementId}`} label={movementName} className={multi(classes.chip, classes.movement)} classes={{ root: classes.chipRoot}} />
          ));
        }
      }
    }

    const blank = /<p><br><\/p>\n?$/;

    let description = viewItem.description;

    while (description.match(blank)) {
      description = description.replace(blank, '');
    }
    description = description.trim();

    return (
      <div>
        <DialogContent className={classes.content}>
        <Grid container spacing={24}>
          <Grid item sm={5}>
            <Paper className={classes.photoFrame} onClick={this.handleImgClick}>
              <img className={classes.imgPreview} src={photoUrl} />
              <FormLabel className={classes.descLabel} component="legend">{(viewItem.photo || '').replace(/\.(jpg|jpeg|png)$/i, '')}</FormLabel>
              <Paper className={classes.springs}>
                { textToSprings(viewItem.springs) }
              </Paper>
            </Paper>
          </Grid>
          <Grid item sm={2}>
          {
            categorisation.length
            ? (
              <List id="exercise-usage">
                { categorisation }
              </List>
            )
            : null
          }
          </Grid>
          <Grid item sm={5}>
            <span id="exercise-description" className={classes.description} dangerouslySetInnerHTML={{ __html: description }}></span>
          </Grid>
        </Grid>
      </DialogContent>
      <DialogActions>
        <Button onClick={this.handleClose} color="primary">
          Close
        </Button>
      </DialogActions>
      </div>
    );
  }
}

export default withStyles(theme => ({
  genres: {
    marginTop: theme.spacing.unit * 2,
    textAlign: 'center',
  },
  movements: {
    textAlign: 'center',
  },
  descLabel: {
    marginTop: theme.spacing.unit,
    marginBottom: theme.spacing.unit,
    color: 'rgba(39, 62, 111, 0.54)',
  },
  editor: {
    border: '1px solid #b2b2b2',
    borderRadius: '5px',
    padding: '5px',
    fontSize: '80%',
  },
  flex: {
    padding: theme.spacing.unit * 3,
    flex: 1,
  },
  content: {
    flexGrow: 1,
    width: 900,
    overflow: 'hidden',
  },
  imgPreview: {
    maxWidth: 300,
    maxHeight: 300,
    borderRadius: 5,
  },
  chip: {
    margin: 5,
    marginLeft: 0,
  },
  photoFrame: {
    padding: theme.spacing.unit,
    textAlign: 'center',
    borderRadius: 10,
    backgroundColor: '#e3e8f2',
    cursor: 'pointer',
    marginTop: 5,
    position: 'relative',
    border: '2px dashed #fffdb3',
    minHeight: 220,
  },
  description: {
    padding: 0,
    display: 'inline-table',
    marginLeft: 5,
  },
  genre: {
    backgroundColor: 'orange',
    marginTop: 3,
    fontSize: '100%',
    color: '#fff',
    width: '100%',
  },
  movement: {
    backgroundColor: '#3f51b5',
    color: '#fff',
    marginTop: 0,
    fontSize: '80%',
    width: '100%',
  },
  springs: {
    right: 10,
    bottom: 10,
    position: 'absolute',
    padding: 4,
    borderRadius: 5,
    color: '#999',
    fontSize: '80%',
    backgroundColor: 'rgba(255,255,255,0.95)',
  },
  noPad: {
    padding: 0,
  },
  chipRoot: {
    height: 25,
  }
}))(ViewExercise);