import React from 'react';
import { withStyles } from "material-ui/styles";
import Lightbox from '../../common/lightbox';
import { multi } from '../../common/util';

const DEFAULT_BORDER = '2px solid #b9b9b9';

class LightLink extends React.Component {
  state = {
    open: false,
  };

  handleClick = () => this.setState({ open: true });
  handleClose = () => this.setState({ open: false });

  onDrop = e => {
    console.log('File(s) dropped');

    // Prevent default behavior (Prevent file from being opened)
    e.preventDefault();

    if (e.dataTransfer.items) {
      // Use DataTransferItemList interface to access the file(s)
      for (let i = 0; i < e.dataTransfer.items.length; i++) {
        // If dropped items aren't files, reject them
        if (e.dataTransfer.items[i].kind === 'file') {
          const file = e.dataTransfer.items[i].getAsFile();
          console.log('... file[' + i + '].name = ' + file.name);
        }
      }
    } else {
      // Use DataTransfer interface to access the file(s)
      for (let i = 0; i < e.dataTransfer.files.length; i++) {
        console.log('... file[' + i + '].name = ' + e.dataTransfer.files[i].name);
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
  };

  onDragOver = e => {
    e.preventDefault();
  };

  onDragEnter = e => e.target.style.border = '2px dashed blue';
  onDragLeave = e => e.target.style.border = DEFAULT_BORDER;
  

  render () {
    const { cacheBust, thumbnail, photo, classes } = this.props;
    
    return (
      <span className={multi(classes.dropZoneContainer, classes.round)} onDrop={this.onDrop} onDragOver={this.onDragOver} onDragEnter={this.onDragEnter} onDragLeave={this.onDragLeave}>
        <img className={multi(classes.dropZoneImg, classes.round)} src={`${thumbnail}?cache=${cacheBust}`} onClick={this.handleClick} />
        {
          this.state.open
          ? <Lightbox src={photo} onClose={this.handleClose} cacheBust={cacheBust}/>
          : null
        }
      </span>
    );
  }
};

export default withStyles({
  dropZoneContainer: {
    display: 'inline-block',
  },
  dropZoneImg: {
    width: 48,
    cursor: 'pointer',
    boxShadow: '1px 8px 10px -4px rgba(0,0,0,0.3)',
    border: DEFAULT_BORDER
  },
  round: {
    borderRadius: 5,
  }
})(LightLink);