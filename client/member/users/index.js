import React from 'react';
import UsersGrid from './grid';

export default class Classes extends React.Component {
  render () {
    return <UsersGrid isAdmin={this.props.isAdmin} />;
  }
};