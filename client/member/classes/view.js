import React from 'react';
import Button from 'material-ui/Button';
import Paper from 'material-ui/Paper';
import Dialog, {
  DialogActions,
  DialogContent,
} from 'material-ui/Dialog';
import { FormLabel } from 'material-ui/Form';
import AppBar from 'material-ui/AppBar';
import Chip from 'material-ui/Chip';
import Typography from 'material-ui/Typography';
import Grid from 'material-ui/Grid';
import { withStyles } from "material-ui/styles";
import { multi } from '../../common/util';
import Lightbox from '../../common/lightbox';
import { textToSprings } from '../exercises/grid';

const styles = theme => ({
  
});

class ViewClass extends React.Component {
  state = {
    open: true,
    lightboxOpen: false
  };

  handleClose = () => {
    this.setState({ open: false });
    this.props.onClose();
  };

  handleImgClose = () => {
    this.setState({ lightboxOpen: false });
  };

  handleImgClick = () => {
    this.setState({ lightboxOpen: true });
  };

  render () {
    // const { viewItem, classes } = this.props;

    return (
      <Dialog
        fullScreen
        open={this.state.open}
        onClose={this.handleClose}
        aria-labelledby="form-dialog-title"
        maxWidth={false}
        disableEscapeKeyDown={false}
        disableBackdropClick={false}
        >
        <p>{this.props.viewItem.name}</p>
      </Dialog>
    );
  }
}

export default withStyles(styles)(ViewClass);