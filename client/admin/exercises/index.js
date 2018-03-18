import React from 'react';
import ExerciseGrid from '../../common/exerciseGrid/';

export default class Exercises extends React.Component {
  render () {
    return <ExerciseGrid readOnly={false} />;
  }
};