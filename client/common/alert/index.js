import React from 'react';
import Button from 'material-ui/Button';
import Dialog, {
  DialogActions,
  DialogContent,
  DialogContentText,
  DialogTitle,
} from 'material-ui/Dialog';

class AlertDialog extends React.Component {
  state = {
    open: true
  };

  handleClickOpen = () => {
    this.setState({ open: true });
  };

  handleCancel = () => {
    this.setState({ open: false });
    this.props.onClose(false);
  };

  handleSubmit = () => {
    this.setState({ open: false });
    this.props.onClose(true);
  };

  render() {
    const { title, message, submitText } = this.props;

    return (
      <Dialog
        open={this.state.open}
        onClose={this.handleCancel}
        aria-labelledby="alert-dialog-title"
        aria-describedby="alert-dialog-description"
      >
        <DialogTitle id="alert-dialog-title">{title}</DialogTitle>
        <DialogContent>
          <DialogContentText id="alert-dialog-description">
            {message}
          </DialogContentText>
        </DialogContent>
        <DialogActions>
          <Button onClick={this.handleCancel}>
            Cancel
          </Button>
          <Button variant="raised" onClick={this.handleSubmit} color="primary" autoFocus>
            {submitText}
          </Button>
        </DialogActions>
      </Dialog>
    );
  }
}

export default AlertDialog;