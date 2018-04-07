/* eslint-disable react/no-multi-comp */

import React from 'react';
import PropTypes from 'prop-types';
import Button from 'material-ui/Button';
import List, { ListItem, ListItemText } from 'material-ui/List';
import Avatar from 'material-ui/Avatar';
import Dialog, { DialogActions, DialogContent, DialogTitle } from 'material-ui/Dialog';
import ImageIcon from 'material-ui-icons/Image';
import Checkbox from 'material-ui/Checkbox';
import { withStyles } from 'material-ui/styles';

class SelectExercises extends React.Component {
  constructor(props, context) {
    super(props, context);

    this.state.value = this.props.value;
  }

  state = {
    selection: {}
  };

  componentWillReceiveProps(nextProps) {
    if (nextProps.value !== this.props.value) {
      this.setState({ value: nextProps.value });
    }
  }

  radioGroup = null;

  handleCancel = () => {
    this.props.onClose();
  };

  handleOk = () => {
    this.props.onClose(Object.keys(this.state.selection).map(id => parseInt(id, 10)));
  };

  handleChange = (event, value) => {
    const selection = this.state.selection;
    if (selection[value]) {
      delete selection[value];
    } else {
      selection[value] = true;
    }
    this.setState({ selection });
  };

  render() {
    const { selection } = this.state;
    const { exercises, classes, ...other } = this.props;
    const count = exercises.length;
    // eslint-disable-next-line no-undef
    const thumbnailUrl = `${PHOENIX_LIB_STORAGE}%_1_thumb.png`;

    return (
      <Dialog
        disableBackdropClick
        disableEscapeKeyDown
        maxWidth="md"
        aria-labelledby="confirmation-dialog-title"
        {...other}
      >
        <DialogTitle id="confirmation-dialog-title">{count} Available Exercise{count === 1 ? '' : 's'}</DialogTitle>
        <DialogContent className={classes.content}>
        <List>
            {exercises.map(exercise => (
              <ListItem key={exercise.id} onClick={e => this.handleChange(e, exercise.id)} className={classes.pointer}>
              <Checkbox
                  checked={!!selection[exercise.id]}
                  
                />
                <Avatar>
                {
                  exercise.photo
                  ? <img src={thumbnailUrl.replace('%', exercise.id)} />
                  : <ImageIcon />
                }
                </Avatar>
                <ListItemText primary={exercise.name} />
              </ListItem>
            ))}
            </List>
        </DialogContent>
        <DialogActions>
          <Button onClick={this.handleCancel} color="primary">
            Cancel
          </Button>
          <Button onClick={this.handleOk} color="primary">
            Ok
          </Button>
        </DialogActions>
      </Dialog>
    );
  }
}

SelectExercises.propTypes = {
  onClose: PropTypes.func,
  value: PropTypes.string,
};

export default withStyles(() => ({
  content: {
    maxHeight: 350,
    backgroundColor: '#f7f7f7',
    borderTop: '1px solid #ccc',
    borderBottom: '1px solid #ccc',
  },
  pointer: {
    cursor: 'pointer'
  }
}))(SelectExercises);
