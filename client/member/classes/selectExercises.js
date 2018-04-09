/* eslint-disable react/no-multi-comp */

import React from 'react';
import PropTypes from 'prop-types';
import Button from 'material-ui/Button';
import List, { ListItem, ListItemText } from 'material-ui/List';
import Avatar from 'material-ui/Avatar';
import Dialog, { DialogActions, DialogContent } from 'material-ui/Dialog';
import AppBar from 'material-ui/AppBar';
import Typography from 'material-ui/Typography';
import ImageIcon from 'material-ui-icons/Image';
import Checkbox from 'material-ui/Checkbox';
import { withStyles } from 'material-ui/styles';
import ViewExercise from '../exercises/view';
import axios from 'axios';

class SelectExercises extends React.Component {
  constructor(props, context) {
    super(props, context);

    this.state.value = this.props.value;
  }

  state = {
    selection: {},
    selectAll: false,
    viewItem: null,
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
    const { exercises } = this.props;
    const selection = this.state.selection;
    if (selection[value]) {
      delete selection[value];
    } else {
      selection[value] = true;
    }
    const selectAll = !!(selectAll && Object.keys(selection).length === exercises.length);
    this.setState({ selectAll, selection });
  };

  handleSelectAllChange = (event, value) => {
    const { exercises } = this.props;
    if (value) {
      const selection = {};
      exercises.forEach(exercise => selection[exercise.id] = true);
      this.setState({ selectAll: true, selection });
    } else {
      this.setState({ selectAll: false, selection: {} });
    }
  };

  onViewClose = () => {
    this.setState({
      viewItem: null
    });
  };

  handleAvatarClick = async exercise => {
    const { data: exerciseWithUsage } = await axios.post('/exercise/usage', {
      exercise
    });
    this.setState({
      viewItem: exerciseWithUsage
    });
  };

  render() {
    const { selection, selectAll, viewItem } = this.state;
    const { exercises, classes } = this.props;
    const count = exercises.length;
    // eslint-disable-next-line no-undef
    const thumbnailUrl = `${PHOENIX_LIB_STORAGE}%_1_thumb.png`;

    return (
      <Dialog
        open={true}
        maxWidth="md"
        aria-labelledby="confirmation-dialog-title"
        onClose={() => this.handleCancel()}
      >
        <AppBar position="static">
          <Typography variant="title" color="inherit" className={classes.flex}>
            {count === 0 ? 'No Exercises Available' : `${count} Exercise${count === 1 ? '' : 's'} Available`}
          </Typography>
        </AppBar>
        <DialogContent className={classes.content}>
        { count === 0 ? <span className={classes.empty}>This movement category is currently empty.</span> : null}
        <List>
            {exercises.map(exercise => (
              <ListItem key={exercise.id} className={classes.item}>
              <Checkbox
                  checked={!!selection[exercise.id]}
                  onClick={e => this.handleChange(e, exercise.id)}
                />
                <Avatar style={{ cursor: 'pointer' }} onClick={() => this.handleAvatarClick(exercise)}>
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
        <DialogActions className={classes.relative}>
          <Button onClick={this.handleCancel} color="primary">
            Cancel
          </Button>
          <Button onClick={this.handleOk} color="primary">
            Ok
          </Button>
          <div className={classes.selectAll} style={{ display: count === 0 ? 'none' : 'block' }}>
            <label><Checkbox onChange={this.handleSelectAllChange} checked={selectAll} /> Select All</label>
          </div>
        </DialogActions>
        {
          viewItem ? <ViewExercise viewItem={viewItem} onClose={this.onViewClose} /> : null
        }
      </Dialog>
    );
  }
}

SelectExercises.propTypes = {
  onClose: PropTypes.func,
  value: PropTypes.string,
};

export default withStyles(theme => ({
  content: {
    maxHeight: 350,
    backgroundColor: '#f7feff',
    borderTop: '1px solid #ccc',
    borderBottom: '1px solid #ccc',
    textAlign: 'center',
  },
  item: {
    cursor: 'pointer',
    padding: 0,
  },
  relative: {
    position: 'relative',
  },
  selectAll: {
    position: 'absolute',
    bottom: -5,
    left: 16,
    fontSize: '90%',
  },
  flex: {
    padding: theme.spacing.unit * 3,
    flex: 1,
  },
  empty: {
    color: '#ccc',
    display: 'inline-block',
    position: 'relative',
    top: 20,
  }
}))(SelectExercises);
