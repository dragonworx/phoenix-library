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
    const { usage, subLabels } = this.props;
    const selections = {};
    const labels = subLabels.map(label => clone(label));
    labels.sort((a, b) => {
      if (a.name < b.name) {
        return -1;
      } else if (a.name > b.name) {
        return 1;
      } else {
        return 0;
      }
    });
    labels.forEach(label => {
      label.selected = usage && (usage[label.id] || null);
      selections[label.id] = label;
    });
    this.labels = labels;
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
    const { anchorEl } = this.state;
    const labels = this.labels;

    return (
      <div>
        <ListItem>
          <ListItemIcon>
            <FolderIcon />
          </ListItemIcon>
          <ListItemText inset primary={rootLabel.name} classes={{ root: classes.listItemRoot }} />
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
                  <MenuItem key={`menu_${label.id}`} onClick={() => this.handleMenuClick(label)} classes={{ root: classes.menuItemRoot }}>
                    <Checkbox checked={label.selected === true} value={String(label.id)} />
                    <ListItemText primary={label.name} classes={{ root: classes.listItemRoot }} />
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
                  <ListItemText inset secondary={label.name} />
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
    backgroundColor: '#e5f1f6',
    borderBottom: '1px solid #e8e8e8',
  },
  menuItemRoot: {
    padding: '5px 5px',
  },
  listItemRoot: {
    padding: '0 2px',
    paddingRight: 12,
  }
})(LabelGroup);