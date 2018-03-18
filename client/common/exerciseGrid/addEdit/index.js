import React from 'react';
import Button from 'material-ui/Button';
import TextField from 'material-ui/TextField';
import Dialog, {
  DialogActions,
  DialogContent,
  DialogTitle,
} from 'material-ui/Dialog';
import { FormLabel } from 'material-ui/Form';
import Input from 'material-ui/Input';
import AppBar from 'material-ui/AppBar';
import Typography from 'material-ui/Typography';
import { Editor, EditorState, RichUtils } from 'draft-js';
import { stateToHTML } from 'draft-js-export-html';
import { stateFromHTML } from 'draft-js-import-html';
import { withStyles } from "material-ui/styles";
import styles from './styles';

const sampleMarkup = `<p>dasdsa</p>
<p><strong>dsadsa</strong></p>
<p><em>dsds</em></p>`;

class AddEdit extends React.Component {
  state = {
    open: true,
    editorState: EditorState.createEmpty()
  };

  componentWillMount () {
    // to restore
    const state = stateFromHTML(sampleMarkup);
    this.setState({editorState: EditorState.createWithContent(state)});
  }

  handleClickOpen = () => {
    this.setState({ open: true });
  };

  handleClose = () => {
    this.setState({ open: false });
    setTimeout(() => this.props.onClose(), 500);
  };

  handleSave = () => {
    console.log(stateToHTML(this.state.editorState.getCurrentContent()));
    this.setState({ open: false });
    setTimeout(() => this.props.onClose(), 500);
  };

  onChange = (editorState) => this.setState({editorState});

  handleEditorKeyCommand = (command, editorState) => {
    const newState = RichUtils.handleKeyCommand(editorState, command);
    if (newState) {
      this.onChange(newState);
      return 'handled';
    }
    return 'not-handled';
  };

  handleFileUpload = (e) => {
    const file = e.target.files[0];
    console.log(file);
  };

  render () {
    const { mode, classes } = this.props;

    return (
      <Dialog
          open={this.state.open}
          onClose={this.handleClose}
          aria-labelledby="form-dialog-title"
        >
        <AppBar position="static">
          <Typography variant="title" color="inherit" className={classes.flex}>
            {mode === 'add' ? 'Enter' : 'Edit'} Exercise Details
          </Typography>
        </AppBar>

        <DialogContent className={classes.content}>
        <TextField
            autoFocus
            margin="dense"
            id="name"
            label="Name"
            type="text"
            fullWidth
          />
          <TextField
            margin="dense"
            id="springs"
            label="Springs"
            type="text"
            fullWidth
          />
          <FormLabel className={classes.descLabel} component="legend">Description</FormLabel>
          <div className={classes.editor} >
            <Editor
              editorState={this.state.editorState}
              handleKeyCommand={this.handleEditorKeyCommand}
              onChange={this.onChange} />
          </div>
          <FormLabel className={classes.descLabel} component="legend">Photo</FormLabel>
          <Input type="file" onChange={this.handleFileUpload} />
          <TextField
            margin="dense"
            id="video"
            label="Video URL"
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

export default withStyles(styles)(AddEdit);

/*
name
springs
description
labels
image
video
*/