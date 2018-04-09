import React from 'react';

export default class Visible extends React.Component {
  render () {
    const { show, children } = this.props;
    if (!show) {
      return null;
    }
    return <React.Fragment>{ children }</React.Fragment>;
  }
}