import React from 'react';
import ClassesGrid from './grid';

export default class Classes extends React.Component {
  render () {
    return <ClassesGrid {...this.props} />;
  }
};