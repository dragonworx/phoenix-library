import React from 'react';
import IconButton from 'material-ui/IconButton';
import Checkbox from 'material-ui/Checkbox';
import Menu, { MenuItem } from 'material-ui/Menu';
import MoreVertIcon from 'material-ui-icons/MoreVert';
import ExerciseIcon from 'material-ui-icons/Dns';
import ClassIcon from 'material-ui-icons/Assignment';
import UserIcon from 'material-ui-icons/AccountBox';
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

const itemStyle = { verticalAlign: 'bottom', marginRight: 10 };

class HamburgerMenu extends React.Component {
  state = {
    anchorEl: null,
  };

  handleClick = event => {
    this.setState({ anchorEl: event.currentTarget });
  };

  handleClose = selectedValue => {
    this.setState({ anchorEl: null });
    this.props.onSelect(selectedValue);
  };

  render() {
    const { options = [], selectedIndex = -1, itemHeight = 48, showUser, isAdmin } = this.props;
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
          {
            showUser
              ? (
                <MenuItem style={{backgroundColor: isAdmin ? 'blue' : 'orange', color: 'rgb(192, 249, 248)', position: 'relative'}}>
                  <span style={{fontSize: '90%', marginRight: 10}}>{user.firstName} {user.lastName.charAt(0).toUpperCase() + '.'}</span>
                  <span style={{position: 'absolute', top: 11, right: 6}}>
                    <a title={`You have ${permissions.toString(0)} permissions for exercises`}><ExerciseIcon style={exerciseStyle} /></a>&nbsp;
                    <a title={`You have ${permissions.toString(1)} permissions for classes`}><ClassIcon style={classStyle} /></a>&nbsp;
                    <a title={`You have ${permissions.toString(2)} permissions for users`}><UserIcon style={userStyle} /></a>
                  </span>
                </MenuItem>
              )
              : null
          }
          {
            options.map(({ value, label, Icon, isChecked }, i) => (
              <MenuItem key={value} selected={i === selectedIndex} onClick={() => this.handleClose(value)}>
                <span key={`hamburger_${i}`}>
                  {
                    typeof isChecked === 'function'
                      ? <Checkbox checked={isChecked()} style={{ width: 25, marginRight: 10 }} />
                      : <Icon style={itemStyle} />
                  }
                  { label }
                </span>
              </MenuItem>
            ))
          }
        </Menu>
      </div>
    );
  }
}

export default HamburgerMenu;