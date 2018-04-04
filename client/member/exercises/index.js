import React from 'react';
import ExerciseGrid from './grid';
import { permissions } from '../session';

export default class Exercises extends React.Component {
  render () {
    return <ExerciseGrid readOnly={!permissions.exercises} />;
  }
};