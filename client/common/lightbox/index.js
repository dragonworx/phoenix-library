import React from 'react';
import Dialog from 'material-ui/Dialog';

class Lightbox extends React.Component {
  handleImageClick = () => {
    this.props.onClose();
  };

  render() {
    const { src, onClose, cacheBust, ...other } = this.props;

    return (
      <Dialog open={true} onClose={onClose} aria-labelledby="image preview" maxWidth={false} {...other}>
        <img src={`${src}?cache=${cacheBust}`} onClick={this.handleImageClick} style={{ cursor: 'pointer'}} />
      </Dialog>
    );
  }
}

module.exports = Lightbox;