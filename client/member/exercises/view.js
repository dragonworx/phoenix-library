import React from 'react';
import Button from 'material-ui/Button';
import Paper from 'material-ui/Paper';
import Dialog, {
  DialogActions,
  DialogContent,
} from 'material-ui/Dialog';
import { FormLabel } from 'material-ui/Form';
import AppBar from 'material-ui/AppBar';
import Chip from 'material-ui/Chip';
import Typography from 'material-ui/Typography';
import Grid from 'material-ui/Grid';
import { withStyles } from "material-ui/styles";
import { multi } from '../../common/util';
import Lightbox from '../../common/lightbox';
import { textToSprings } from '../exercises/grid';

class ViewExercise extends React.Component {
  state = {
    open: true,
    lightboxOpen: false
  };

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
              "{viewItem.name.trim()}"
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
    const { classes, viewItem } = this.props;

    // eslint-disable-next-line no-undef
    const photoUrl = viewItem.photo ? `${PHOENIX_LIB_STORAGE}${viewItem.id}_1_preview.png` : '/img/image-placeholder.png';
    const genres = viewItem.genre.map(genre => <Chip key={`genre_${genre}`} label={genre} className={multi(classes.chip, classes.genre)} />);
    const movements = viewItem.movement.map(movement => <Chip key={`movement_${movement}`} label={movement} className={multi(classes.chip, classes.movement)} />);
    let description = viewItem.description;
    const blank = /<p><br><\/p>\n?$/;
    while (description.match(blank)) {
      description = description.replace(blank, '');
    }
    description = description.trim();
    return (
      <div>
        <DialogContent className={classes.content}>
        <Grid container spacing={24}>
          <Grid item xs={12} sm={6}>
            <Paper className={classes.photoFrame} onClick={this.handleImgClick}>
              <img className={classes.imgPreview} src={photoUrl} />
              <FormLabel className={classes.descLabel} component="legend">{(viewItem.photo || '').replace(/\.(jpg|jpeg|png)$/i, '')}</FormLabel>
            </Paper>
            <div className={classes.usage}>{ genres }</div>
            <div>{ movements }</div>
          </Grid>
          <Grid item xs={12} sm={6}>
            <Paper className={classes.description}>
              <span dangerouslySetInnerHTML={{ __html: description }}></span>
              { textToSprings(viewItem.springs) }
            </Paper>
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
  usage: {
    marginTop: theme.spacing.unit * 2
  },
  descLabel: {
    marginTop: theme.spacing.unit,
    marginBottom: theme.spacing.unit,
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
    width: 700,
  },
  imgPreview: {
    maxWidth: 300,
    maxHeight: 300,
    borderRadius: 5,
  },
  chip: {
    margin: theme.spacing.unit,
  },
  photoFrame: {
    padding: theme.spacing.unit,
    textAlign: 'center',
    borderRadius: 10,
    backgroundColor: '#e0e6f0',
    cursor: 'pointer',
  },
  description: {
    padding: theme.spacing.unit
  },
  genre: {
    backgroundColor: 'orange',
  },
  movement: {
    backgroundColor: '#3f51b5',
    color: '#fff'
  },
}))(ViewExercise);