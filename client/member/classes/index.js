import React from 'react';
import ClassesGrid from './grid';
import { permissions } from '../session';

export default class Classes extends React.Component {
  render () {
    return <ClassesGrid readOnly={permissions.isClassReadOnly} />;
  }
};