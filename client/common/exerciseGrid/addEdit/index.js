import React from 'react';
import Button from 'material-ui/Button';
import TextField from 'material-ui/TextField';
import Dialog, {
  DialogActions,
  DialogContent,
} from 'material-ui/Dialog';
import { FormLabel } from 'material-ui/Form';
import Input from 'material-ui/Input';
import AppBar from 'material-ui/AppBar';
import Typography from 'material-ui/Typography';
import Snackbar from 'material-ui/Snackbar';
import Grid from 'material-ui/Grid';
import { Editor, EditorState, RichUtils } from 'draft-js';
import { stateToHTML } from 'draft-js-export-html';
import { stateFromHTML } from 'draft-js-import-html';
import { withStyles } from "material-ui/styles";
import { LinearProgress } from 'material-ui/Progress';
import axios from 'axios';
import SaveButton from '../../saveButton';
import ExerciseLabels from '../../../admin/exerciseLabels';
import styles from './styles';

const ERROR = {
  IMAGE_FORMAT: 'Invalid image, only use PNG or JPG',
  SAVE: 'An error occurred, could not save data'
};

const MODE = {
  ADD: 'add',
  EDIT: 'edit',
};

const ACCEPT_DELAY = 500;

class AddEdit extends React.Component {
  state = {
    open: true,
    editorState: EditorState.createEmpty(),
    error: null,
  };

  constructor (props) {
    super(props);
    this.usage = {};
  }

  componentWillMount () {
    const { editItem } = this.props;
    if (editItem) {
      const state = stateFromHTML(editItem.description);
      this.usage = editItem.usage;
      this.setState({editorState: EditorState.createWithContent(state)});
    }
  }

  get defaultItem () {
    const { editItem } = this.props;
    const item = {
      name: '',
      springs: '',
      description: '',
      video: '',
    };
    if (editItem) {
      item.name = editItem.name;
      item.springs = editItem.springs;
      item.name = editItem.name;
      item.description = editItem.description;
      item.video = editItem.video;
    }
    return item;
  }

  get values () {
    return {
      name: document.getElementById('addEdit_name').value,
      springs: document.getElementById('addEdit_springs').value,
      description: stateToHTML(this.state.editorState.getCurrentContent()),
      photo: document.getElementById('addEdit_photo').files[0],
      video: document.getElementById('addEdit_video').value
    };
  }

  getSelectedLabels () {
    const usage = {};
    Object.entries(this.usage).forEach(({ 0: rootLabelId, 1: subLabels }) => {
      const selectedSubLabels = Object.entries(subLabels).filter(({ 1: subLabel }) => subLabel.selected).map(kv => kv[1]);
      const ids = {};
      selectedSubLabels.map(subLabel => ids[subLabel.id] = true);
      usage[rootLabelId] = ids;
    });
    return usage;
  }

  handleClickOpen = () => {
    this.setState({ open: true });
  };

  handleClose = () => {
    this.setState({ open: false });
    setTimeout(() => this.props.onClose(), ACCEPT_DELAY);
  };

  handleSave = () => {
    const { mode, editItem } = this.props;
    const values = this.values;
    const usage = this.getSelectedLabels();
    const data = new FormData();
    data.append('name', values.name);
    data.append('springs', values.springs);
    data.append('description', values.description);
    data.append('photo', values.photo);
    data.append('video', values.video);
    data.append('usage', JSON.stringify(usage));
    if (editItem) {
      data.append('id', editItem.id);
    }
    return axios.post(`/exercise/${mode}`, data, {
      headers: { 'content-type': 'multipart/form-data' }
    }).then(res => {
      setTimeout(() => {
        const id = res.data.id;
        values.id = id;
        this.setState({ open: false });
        this.props.onClose();
        if (mode === 'add') {
          this.props.onAdded(values, usage);
        } else {
          this.props.onSaved(values, usage);
        }
      }, ACCEPT_DELAY);
    }).catch(() => {
      this.setState({ error: ERROR.SAVE });
      return Promise.reject();
    });
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

  handleFileUpload = e => {
    const file = e.target.files[0];
    const type = file.type;
    if (type !== 'image/png' && type !== 'image/jpeg') {
      e.target.value = '';
      this.setState({ error: ERROR.IMAGE_FORMAT });
    } else {
      this.setState({ error: null });
    }
  };

  handleCloseSnackbar = () => {
    this.setState({ error: null });
  };

  handleExerciseLabelChange = (rootLabel, selections) => {
    this.usage[rootLabel.id] = selections;
  };

  render () {
    const { mode, classes } = this.props;

    return (
      <Dialog
          open={this.state.open}
          onClose={this.handleClose}
          aria-labelledby="form-dialog-title"
          maxWidth="md"
        >
        <AppBar position="static">
          <Typography variant="title" color="inherit" className={classes.flex}>
            {mode === 'add' ? 'New' : 'Edit'} Exercise
          </Typography>
        </AppBar>

        { this.renderContent() }
        
      </Dialog>
    );
  }

  renderLoading () {
    const { classes } = this.props;

    return (
      <DialogContent className={classes.content}>
        <LinearProgress />
      </DialogContent>
    );
  }

  renderContent () {
    const { error } = this.state;
    const { classes, labels } = this.props;
    const hasError = !!error;
    const defaultItem = this.defaultItem;
    const usage = this.usage;
    
    return (
      <div>
        <DialogContent className={classes.content}>
        <Grid container spacing={24}>
          <Grid item xs={12} sm={6}>
            <TextField
                autoFocus
                margin="dense"
                id="addEdit_name"
                label="Name"
                type="text"
                fullWidth
                defaultValue={defaultItem.name}
              />
              <TextField
                margin="dense"
                id="addEdit_springs"
                label="Springs"
                type="text"
                fullWidth
                defaultValue={defaultItem.springs}
              />
              <FormLabel className={classes.descLabel} component="legend">Description</FormLabel>
              <div className={classes.editor} >
                <Editor
                  editorState={this.state.editorState}
                  handleKeyCommand={this.handleEditorKeyCommand}
                  onChange={this.onChange} />
              </div>
              <FormLabel className={classes.descLabel} component="legend">Photo</FormLabel>
              <Input id="addEdit_photo" type="file" onChange={this.handleFileUpload} error={error === ERROR.IMAGE_FORMAT} />
              <TextField
                margin="dense"
                id="addEdit_video"
                label="Video URL"
                type="text"
                fullWidth
                defaultValue={defaultItem.video}
              />
          </Grid>
          <Grid item xs={12} sm={6}>
            <ExerciseLabels onChange={this.handleExerciseLabelChange} usage={usage} labels={labels} />
          </Grid>
        </Grid>
      </DialogContent>
      <DialogActions>
        <Button onClick={this.handleClose} color="primary">
          Cancel
        </Button>
        <SaveButton onClick={this.handleSave} />
      </DialogActions>
      <Snackbar
          open={hasError}
          autoHideDuration={5000}
          onClose={this.handleCloseSnackbar}
          SnackbarContentProps={{
            'aria-describedby': 'snackbar-fab-message-id',
            className: classes.snackbarContent,
          }}
          message={<span id="snackbar-fab-message-id">{error}</span>}
          action={
            <Button color="inherit" size="small" onClick={this.handleCloseSnackbar}>
              Ok
            </Button>
          }
          className={classes.snackbar}
        />
      </div>
    );
  }
}

export default withStyles(styles)(AddEdit);