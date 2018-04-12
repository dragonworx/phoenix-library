import React from 'react';
import IconButton from 'material-ui/IconButton';
import Menu, { MenuItem } from 'material-ui/Menu';
import MoreVertIcon from 'material-ui-icons/MoreVert';
import ExerciseIcon from 'material-ui-icons/Dns';
import ClassIcon from 'material-ui-icons/Assignment';
import UserIcon from 'material-ui-icons/AccountBox';
import Tooltip from 'material-ui/Tooltip';
import { user, permissions } from '../../member/session';

const forbiddenStyle = {display: 'none'};
const readOnlyStyle = {opacity: 0.5};
const readWriteStyle = {};
const readWriteDeleteStyle = {color: '#fff'};
const styles = {
  0: forbiddenStyle,
  1: readOnlyStyle,
  2: readWriteStyle,
  3: readWriteDeleteStyle,
};
const exerciseStyle = styles[permissions.exerciseLevel];
const classStyle = styles[permissions.classLevel];
const userStyle = styles[permissions.userLevel];

class HamburgerMenu extends React.Component {
  state = {
    anchorEl: null,
  };

  handleClick = event => {
    this.setState({ anchorEl: event.currentTarget });
  };

  handleClose = selectedIndex => {
    this.setState({ anchorEl: null });
    this.props.onSelect(selectedIndex);
  };

  render() {
    const { options = [], selectedIndex = 0, itemHeight = 48 } = this.props;
    const { anchorEl } = this.state;

    return (
      <div className={this.props.className}>
        <IconButton
          aria-label="More"
          aria-owns={anchorEl ? 'long-menu' : null}
          aria-haspopup="true"
          onClick={this.handleClick}
        >
          <MoreVertIcon color="secondary" style={{color:'#fff'}}/>
        </IconButton>
        <Menu
          id="long-menu"
          anchorEl={anchorEl}
          open={Boolean(anchorEl)}
          onClose={this.handleClose}
          PaperProps={{
            style: {
              maxHeight: itemHeight * 4.5,
              width: 200,
            },
          }}
        >
          <MenuItem style={{backgroundColor: 'rgb(48 158 145)', color: 'rgb(192, 249, 248)', position: 'relative'}}>
            <span style={{fontSize: '90%', marginRight: 10}}>{user.firstName} {user.lastName.charAt(0).toUpperCase() + '.'}</span>
            <span style={{position: 'absolute', top: 11, right: 6}}><ExerciseIcon style={exerciseStyle} /> <ClassIcon style={classStyle} /> <UserIcon style={userStyle} /></span>
          </MenuItem>
          {options.map((option, i) => (
            <MenuItem key={option} selected={i === selectedIndex} onClick={this.handleClose.bind(this, [i, option])}>
              {option}
            </MenuItem>
          ))}
        </Menu>
      </div>
    );
  }
}

export default HamburgerMenu;