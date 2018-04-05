import React from 'react';

export default class ClassProgram extends React.Component {
  render () {
    const { program } = this.props;

    return (
      program.map(category => (
        <p key={`category_${category.labelId}`}>{category.name}</p>
      ))
    );
  }
};