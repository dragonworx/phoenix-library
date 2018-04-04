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
import { clone } from '../../../../common/util';

const MENU_HEIGHT = 78;

class LabelGroup extends React.Component {
  state = {
    anchorEl: null,
    selections: {},
  };

  constructor (props) {
    super(props);
    const { usage } = this.props;
    const selections = {};
    this.props.subLabels.forEach(label => {
      const labelCopy = clone(label);
      labelCopy.selected = usage && (usage[label.id] || null);
      selections[label.id] = labelCopy;
    });
    this.state.selections = selections;
  }

  handleClick = event => {
    this.setState({ anchorEl: event.currentTarget });
  };

  handleClose = () => {
    this.setState({ anchorEl: null });
  };

  handleMenuClick = (label) => {
    const { selections } = this.state;
    label.selected = !label.selected;
    this.setState({ selections });
    this.props.onChange(this.props.rootLabel, selections);
  };

  render() {
    const { classes, rootLabel } = this.props;
    const { anchorEl, selections } = this.state;
    const labels = Object.entries(selections).map(({ 1: label }) => label);

    return (
      <div>
        <ListItem>
          <ListItemIcon>
            <FolderIcon />
          </ListItemIcon>
          <ListItemText inset primary={rootLabel.id + ':' + rootLabel.name} />
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
                labels.map(label => (
                  <MenuItem key={`menu_${label.id}`} onClick={() => this.handleMenuClick(label)}>
                    <Checkbox checked={label.selected === true} value={String(label.id)} />
                    <ListItemText primary={label.id + ':' + label.name} />
                  </MenuItem>
                ))
              }
            </Menu>
          </ListItemSecondaryAction>
        </ListItem>
        {
          labels.map(label => (
            label.selected
              ? <ListItem key={`item_${label.id}`} className={classes.subItem}>
                  <ListItemIcon>
                    <CheckIcon />
                  </ListItemIcon>
                  <ListItemText inset secondary={label.id + ':' + label.name} />
                </ListItem>
              : null
          ))
        }
      </div>
    );
  }
}

export default withStyles({
  subItem: {
    maxHeight: 20,
  }
})(LabelGroup);