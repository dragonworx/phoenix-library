import React from 'react';
import Dialog from 'material-ui/Dialog';

class Lightbox extends React.Component {
  handleImageClick = () => {
    this.props.onClose();
  };

  render() {
    const { name, src, onClose, ...other } = this.props;
    const cache = `?now=${Date.now()}`;

    return (
      <Dialog open={true} onClose={onClose} aria-labelledby="image preview" maxWidth={false} {...other}>
        <img title={name} src={`${src}${cache}`} onClick={this.handleImageClick} style={{ cursor: 'pointer'}} />
      </Dialog>
    );
  }
}

module.exports = Lightbox;