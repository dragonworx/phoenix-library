import React from 'react';
import Button from 'material-ui/Button';
import Card, { CardActions, CardContent, CardMedia } from 'material-ui/Card';
import Dialog from 'material-ui/Dialog';
import Chip from 'material-ui/Chip';
import Typography from 'material-ui/Typography';
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
    const { viewItem } = this.props;
    const { photo } = viewItem;
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
          { this.renderContent() }
        </Dialog>
        {
          lightboxOpen ? <Lightbox name={photo} src={photoUrl} onClose={this.handleImgClose} /> : null
        }
      </div>
    );
  }

  renderContent () {
    const { labels } = this.state;
    const { classes, viewItem } = this.props;
    const { photo, description, name, springs } = viewItem;

    // eslint-disable-next-line no-undef
    const photoUrl = photo ? `${PHOENIX_LIB_STORAGE}${viewItem.id}_1_preview.png` : '/img/image-placeholder.png';

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

    const blank = /<p><br><\/p>/;

    let __html = description;

    while (__html.match(blank)) {
      __html = __html.replace(blank, '');
    }
    __html = __html.trim();

    return (
      <Card className={classes.card}>
        <CardMedia
          className={classes.media}
          image={photoUrl}
          title={viewItem.photo}
          onClick={this.handleImgClick}
          style={{ cursor: 'pointer' }}
        />
        <CardContent style={{ paddingBottom: 5 }}>
          <Typography className={classes.name} gutterBottom variant="headline" component="h2">
            { name }
          </Typography>
          <Typography className={classes.description} component="p" dangerouslySetInnerHTML={{ __html }} />
        </CardContent>
        <CardActions>
          <Button size="small" color="primary" onClick={this.handleClose}>
            Close
          </Button>
          <div className={classes.springsContainer}>
            { textToSprings(springs) }
          </div>
        </CardActions>
      </Card>
    );
  }
}

export default withStyles(theme => ({
  springsContainer: {
    right: 23,
    top: 215,
    position: 'absolute',
  },
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
    width: 800,
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
    fontSize: '80%',
    color: '#fff',
    width: '100%',
  },
  movement: {
    backgroundColor: '#3f51b5',
    color: '#fff',
    marginTop: 0,
    fontSize: '70%',
    width: '100%',
  },
  springs: {
    left: 10,
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
  },
  card: {
    maxWidth: 600,
  },
  media: {
    height: 200,
  },
  name: {
    color: '#377ec2',
  }
}))(ViewExercise);