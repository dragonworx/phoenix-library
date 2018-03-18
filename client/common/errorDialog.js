import React from 'react';
import Button from 'material-ui/Button';
import Dialog, {
  DialogActions,
  DialogContent,
  DialogContentText,
  DialogTitle,
} from 'material-ui/Dialog';

class AlertDialog extends React.Component {
  handleAction = () => {
    location.reload();
  };

  render() {
    return (
      <Dialog
          open={true}
          onClose={this.handleClose}
          aria-labelledby="alert-dialog-title"
          aria-describedby="alert-dialog-description"
        >
          <DialogTitle id="alert-dialog-title">{"An Error Occurred"}</DialogTitle>
          <DialogContent>
            <DialogContentText id="alert-dialog-description" style={{ fontSize: '80%', whiteSpace: 'pre-wrap' }}>
              {this.props.message}
            </DialogContentText>
          </DialogContent>
          <DialogActions>
            <Button onClick={this.handleAction} color="primary" autoFocus>
              Reload
            </Button>
          </DialogActions>
        </Dialog>
    );
  }
}

export default AlertDialog;