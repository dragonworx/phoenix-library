import React from 'react';
import Button from 'material-ui/Button';
import TextField from 'material-ui/TextField';
import Dialog from 'material-ui/Dialog';
import { 
  DialogActions,
   DialogContent, 
   DialogContentText, 
   DialogTitle 
} from 'material-ui/Dialog';
import { plural } from '../../common/util';
import axios from 'axios';

export default class SetPassword extends React.Component {
  state = {
    open: true,
  };

  handleClose = () => {
    this.setState({ open: false });
    this.props.onClose();
  };

  handleSave = async () => {
    const { selection } = this.props;
    const password = document.getElementById('password');
    await axios.post('/user/password/set', {
      ids: selection,
      password: password.value,
    });
    this.handleClose();
  };

  render() {
    const { selection } = this.props;
    return (
      <Dialog
          open={this.state.open}
          onClose={this.handleClose}
          aria-labelledby="form-dialog-title"
        >
          <DialogTitle id="form-dialog-title">Set Password</DialogTitle>
          <DialogContent>
            <DialogContentText>
              Enter the new password to apply to {plural(selection.length, 'user')}.
            </DialogContentText>
            <TextField
              autoFocus
              margin="dense"
              id="password"
              label="New Password"
              type="text"
              fullWidth
            />
          </DialogContent>
          <DialogActions>
            <Button onClick={this.handleClose} color="primary">
              Cancel
            </Button>
            <Button onClick={this.handleSave} color="primary">
              Save
            </Button>
          </DialogActions>
        </Dialog>
    );
  }
}