import React from 'react';
import Lightbox from '../../common/lightbox';

export default class LightLink extends React.Component {
  state = {
    open: false,
  };

  handleClick = () => this.setState({ open: true });
  handleClose = () => this.setState({ open: false });

  render () {
    const { cacheBust, thumbnail, photo } = this.props;
    
    return (
      <span>
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