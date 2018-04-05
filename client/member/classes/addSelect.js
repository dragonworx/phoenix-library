import React from 'react';
import Button from 'material-ui/Button';
import Select from 'material-ui/Select';
import { MenuItem } from 'material-ui/Menu';
import Dialog, {
  DialogActions,
  DialogContent,
} from 'material-ui/Dialog';
import { FormLabel } from 'material-ui/Form';
import AppBar from 'material-ui/AppBar';
import Typography from 'material-ui/Typography';
import Grid from 'material-ui/Grid';
import { withStyles } from "material-ui/styles";

const ACCEPT_DELAY = 500;

class AddSelect extends React.Component {
  state = {
    open: true,
    value: 1,
  };

  handleSave = () => {
    this.props.onClose(this.state.value);
    return Promise.resolve(true);
  };

  handleClose = () => {
    this.setState({ open: false });
    setTimeout(() => this.props.onClose(), ACCEPT_DELAY);
  };

  handleChange = e => {
    this.setState({ value: e.target.value });
  };

  render () {
    const { classes } = this.props;

    return (
      <Dialog
          open={this.state.open}
          onClose={this.handleClose}
          aria-labelledby="form-dialog-title"
          maxWidth="md"
        >
        <AppBar position="static">
          <Typography variant="title" color="inherit" className={classes.flex}>
            Create Class
          </Typography>
        </AppBar>

        { this.renderContent() }
        
      </Dialog>
    );
  }

  renderContent () {
    const { value } = this.state;
    const { classes, genres } = this.props;
    
    return (
      <div>
        <DialogContent className={classes.content}>
        <Grid container spacing={24}>
          <Grid item xs={12}>
            <FormLabel className={classes.descLabel} component="legend">Genre</FormLabel>
            <Select
              className={classes.select}
              value={value}
              onChange={this.handleChange}
            >
              {
                genres.map(genre => <MenuItem key={`genre_${genre.id}`} value={genre.id}>{genre.name}</MenuItem>)
              }
            </Select>
          </Grid>
        </Grid>
      </DialogContent>
      <DialogActions>
        <Button onClick={this.handleClose} color="primary">
          Cancel
        </Button>
        <Button onClick={this.handleSave} variant="raised" color="primary">
          Select
        </Button>
      </DialogActions>
      </div>
    );
  }
}

export default withStyles(theme => ({
  select: {
    width: '100%',
  },
  descLabel: {
    marginTop: theme.spacing.unit * 3,
    marginBottom: theme.spacing.unit,
  },
  flex: {
    padding: theme.spacing.unit * 3,
    flex: 1,
  },
  content: {
    flexGrow: 1,
    width: 200,
  },
}))(AddSelect);