import React from 'react';
import Dialog from 'material-ui/Dialog';
import Paper from 'material-ui/Paper';
import { withStyles } from "material-ui/styles";

class Lightbox extends React.Component {
  handleImageClick = () => {
    this.props.onClose();
  };

  render() {
    const { classes, name, src, onClose, ...other } = this.props;
    const cache = `?now=${Date.now()}`;

    return (
      <Dialog open={true} onClose={onClose} aria-labelledby="image preview" maxWidth={false} {...other}>
        <Paper className={classes.frame}>
          <img title={name} src={`${src}${cache}`} onClick={this.handleImageClick} style={{ cursor: 'pointer' }} />
        </Paper>
      </Dialog>
    );
  }
}

export default withStyles(theme => ({
  frame: {
    padding: theme.spacing.unit
  },
}))(Lightbox);