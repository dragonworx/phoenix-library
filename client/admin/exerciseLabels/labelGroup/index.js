import React from 'react';
import { withStyles } from 'material-ui/styles';
import FolderIcon from 'material-ui-icons/Folder';
import CheckIcon from 'material-ui-icons/Done';
import {
  ListItem,
  ListItemIcon,
  ListItemSecondaryAction,
  ListItemText,
} from 'material-ui/List';
import IconButton from 'material-ui/IconButton';
import Checkbox from 'material-ui/Checkbox';
import MoreVertIcon from 'material-ui-icons/MoreVert';
import Menu, { MenuItem } from 'material-ui/Menu';
import styles from './styles';

const MENU_HEIGHT = 78;

class LabelGroup extends React.Component {
  state = {
    anchorEl: null,
    options: {},
  };

  constructor (props) {
    super(props);
    this.state.options = this.props.options;
  }

  handleClick = event => {
    this.setState({ anchorEl: event.currentTarget });
  };

  handleClose = () => {
    this.setState({ anchorEl: null });
  };

  handleCheck = (e, checked) => {
    const options = {
      ...this.state.options
    };
    options[e.target.value] = checked;
    this.setState({ options });
    this.props.onChange(this.props.title, options);
  };

  handleMenuClick = (key) => {
    const options = {
      ...this.state.options
    };
    options[key] = !options[key];
    this.setState({ options });
    this.props.onChange(this.props.title, options);
  };

  render() {
    const { classes, title } = this.props;
    const { anchorEl, options } = this.state;
    const keys = Object.keys(options);

    return (
      <div>
        <ListItem>
          <ListItemIcon>
            <FolderIcon />
          </ListItemIcon>
          <ListItemText inset primary={title} />
          <ListItemSecondaryAction>
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
                  maxHeight: MENU_HEIGHT * 4.6,
                  maxWidth: 400,
                },
              }}
            >
              {
                keys.map(key => (
                  <MenuItem key={`menu_${key}`} onClick={() => this.handleMenuClick(key)}>
                    <Checkbox checked={options[key]} value={key} />
                    <ListItemText primary={key} />
                  </MenuItem>
                ))
              }
            </Menu>
          </ListItemSecondaryAction>
        </ListItem>
        {
          keys.map(key => (
            options[key]
              ? <ListItem key={`item_${key}`} className={classes.subItem}>
                  <ListItemIcon>
                    <CheckIcon />
                  </ListItemIcon>
                  <ListItemText inset secondary={key} />
                </ListItem>
              : null
          ))
        }
      </div>
    );
  }
}

export default withStyles(styles)(LabelGroup);