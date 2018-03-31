import React from 'react';
import IconButton from 'material-ui/IconButton';
import Menu, { MenuItem } from 'material-ui/Menu';
import MoreVertIcon from 'material-ui-icons/MoreVert';

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
          <MoreVertIcon />
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