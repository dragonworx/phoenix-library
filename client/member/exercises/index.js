import React from 'react';
import ExerciseGrid from './grid';

export default class Exercises extends React.Component {
  render () {
    return <ExerciseGrid {...this.props} />;
  }
};