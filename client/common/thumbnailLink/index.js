import React from 'react';
import { withStyles } from "material-ui/styles";
import Lightbox from '../../common/lightbox';

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

  onDragEnter = e => {
    e.target.style.border = '3px dashed orange';
  };
  

  render () {
    const { cacheBust, thumbnail, photo, classes } = this.props;
    
    return (
      <span className={classes.dropZone} onDrop={this.onDrop} onDragOver={this.onDragOver} onDragEnter={this.onDragEnter}>
        <img src={`${thumbnail}?cache=${cacheBust}`} style={{ width: 48, cursor: 'pointer', boxShadow: '1px 8px 10px -4px rgba(0,0,0,0.3)', border: '1px solid #b9b9b9' }} onClick={this.handleClick} />
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
  dropZone: {
    display: 'inline-block',
  }
})(LightLink);