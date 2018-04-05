import React from 'react';
import { withStyles } from 'material-ui/styles';
import { CircularProgress } from 'material-ui/Progress';
import green from 'material-ui/colors/green';
import red from 'material-ui/colors/red';
import axios from 'axios';
import Lightbox from '../../common/lightbox';
import ViewExercise from '../../member/exercises/view';
import { multi } from '../../common/util';

const DEFAULT_BORDER = '2px solid #b9b9b9';

class LightLink extends React.Component {
  state = {
    open: false,
    isSaving: false,
    error: null,
    preview: false,
  };

  handleNoImageClick = () => {
    this.setState({ open: true, preview: true });
  }
  handleClick = e => {
    let preview = false;
    if (e.altKey) {
      preview = true;
    }
    this.setState({ open: true, preview });
  }
  handleClose = () => this.setState({ open: false });

  onDrop = e => {
    const row = this.props.row;
    const { id } = row;

    console.log('File(s) dropped');

    // Prevent default behavior (Prevent file from being opened)
    e.preventDefault();

    const files = [];

    if (e.dataTransfer.items) {
      // Use DataTransferItemList interface to access the file(s)
      for (let i = 0; i < e.dataTransfer.items.length; i++) {
        // If dropped items aren't files, reject them
        if (e.dataTransfer.items[i].kind === 'file') {
          const file = e.dataTransfer.items[i].getAsFile();
          files.push(file);
        }
      }
    } else {
      // Use DataTransfer interface to access the file(s)
      for (let i = 0; i < e.dataTransfer.files.length; i++) {
        const file = e.dataTransfer.files[i];
        files.push(file);
      }
    } 
    
    // Pass event to removeDragData for cleanup
    if (e.dataTransfer.items) {
      // Use DataTransferItemList interface to remove the drag data
      e.dataTransfer.items.clear();
    } else {
      // Use DataTransfer interface to remove the drag data
      e.dataTransfer.clearData();
    }

    if (files.length >= 1) {
      this.setState({ isSaving: true });
      const data = new FormData();
      data.append('exerciseId', id);
      data.append('photo', files[0]);
      return axios.put('/exercise/photo', data, {
        headers: { 'content-type': 'multipart/form-data' }
      }).then(res => {
        const { data: { photo } } = res;
        row.photo = photo || row.photo;
        this.setState({ isSaving: false });
      }).catch(error => {
        this.setState({ error });
        setTimeout(() => this.setState({ isSaving: false, error: null }), 1000);
      });
    }
  };

  onDragOver = e => {
    e.preventDefault();
  };

  onDragEnter = e => e.target.style.border = '2px dashed #34c4cb';
  onDragLeave = e => e.target.style.border = DEFAULT_BORDER;

  onViewClose = () => {
    this.setState({ open: false, preview: false });
  };

  render () {
    const { open, isSaving, error, preview } = this.state;
    const { classes, row } = this.props;
    const { id, photo } = row;
    const cache = `?now=${Date.now()}`;
    // eslint-disable-next-line no-undef
    const photoUrl = `${PHOENIX_LIB_STORAGE}${id}_1_full.png`;
    // eslint-disable-next-line no-undef
    const thumbnailUrl = `${PHOENIX_LIB_STORAGE}${id}_1_thumb.png`;
    
    return (
      <span className={multi(classes.dropZoneContainer, classes.round)}>
        {
          isSaving
            ? <CircularProgress size={48} className={error ? classes.error : classes.progress} />
            : photo
                ? <img title={photo} className={multi(classes.dropZoneImg, classes.round)} src={`${thumbnailUrl}${cache}`} onClick={this.handleClick}
                     onDrop={this.onDrop} onDragOver={this.onDragOver} onDragEnter={this.onDragEnter} onDragLeave={this.onDragLeave} />
                : <img title="No image set" className={multi(classes.dropZoneImg, classes.round)} src="/img/image-placeholder.png" onClick={this.handleNoImageClick}
                     onDrop={this.onDrop} onDragOver={this.onDragOver} onDragEnter={this.onDragEnter} onDragLeave={this.onDragLeave} />
        }
        {
          open && !preview
          ? <Lightbox name={photo} src={photoUrl} onClose={this.handleClose} />
          : null
        }
        {
          open && preview
          ? <ViewExercise viewItem={row} onClose={this.onViewClose} />
          : null
        }
      </span>
    );
  }
};

export default withStyles({
  dropZoneContainer: {
    display: 'inline-block',
    position: 'relative',
    width: 52,
    height: 52,
    display: 'flex',
    alignItems: 'center',
    justifyContent: 'center',
    cursor: 'pointer',
  },
  dropZoneImg: {
    maxWidth: 48,
    maxHeight: 48,    
    cursor: 'pointer',
    boxShadow: '1px 8px 10px -4px rgba(0,0,0,0.3)',
    border: 'red',
  },
  round: {
    borderRadius: 5,
  },
  progress: {
    color: green[500],
    position: 'absolute',
    top: '50%',
    left: '50%',
    marginTop: -24,
    marginLeft: -24,
  },
  error: {
    color: red[500],
    position: 'absolute',
    top: '50%',
    left: '50%',
    marginTop: -24,
    marginLeft: -24,
  },
})(LightLink);