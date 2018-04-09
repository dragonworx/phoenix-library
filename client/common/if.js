import React from 'react';

export default class If extends React.Component {
  render () {
    const { test, children } = this.props;
    if (!test) {
      return null;
    }
    return <React.Fragment>{ children }</React.Fragment>;
  }
}