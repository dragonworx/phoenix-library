import React from 'react';
import ExerciseGrid from './grid';

export default class Exercises extends React.Component {
  render () {
    const { isAdmin, isSuper } = this.props;

    return <ExerciseGrid readOnly={!(isAdmin || isSuper)} />;
  }
};