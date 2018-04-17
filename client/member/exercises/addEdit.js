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
import SaveButton from '../../common/saveButton';
import ExerciseLabels from './usage';
import { clone, css, trimUsage } from '../../common/util';

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
    isSaving: false,
    exerciseName: null,
  };

  constructor (props) {
    super(props);
    this.usage = {};
    this.state.exerciseName = props.name;
  }

  componentWillMount () {
    const { editItem, labels } = this.props;
    if (editItem) {
      const state = stateFromHTML(editItem.description);
      const usage = clone(editItem.usage);
      Object.entries(usage).forEach(({ 1: selections }) => {
        Object.entries(selections).forEach(({ 0: movementId, 1: isSelected }) => {
          const label = labels.find(label => label.id === parseInt(movementId, 10));
          selections[movementId] = clone(label);
          selections[movementId].selected = isSelected;
        });
      });
      this.usage = usage;
      this.setState({editorState: EditorState.createWithContent(state)});
    }
  }

  get defaultItem () {
    const { mode, editItem } = this.props;
    const item = {
      name: '',
      springs: '',
      description: '',
      video: '',
    };
    if (mode === MODE.EDIT && editItem) {
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
      name: this.state.exerciseName,
      springs: document.getElementById('addEdit_springs').value,
      description: stateToHTML(this.state.editorState.getCurrentContent()),
      photo: document.getElementById('addEdit_photo').files[0],
      video: document.getElementById('addEdit_video').value
    };
  }

  getSelectedLabels () {
    const usage = {};
    Object.entries(this.usage).forEach(({ 0: rootLabelId, 1: subLabels }) => {
      const selectedSubLabels = Object.entries(subLabels).filter(({ 1: subLabel }) => typeof subLabel.selected === 'boolean').map(kv => kv[1]);
      const ids = {};
      selectedSubLabels.map(subLabel => ids[subLabel.id] = subLabel.selected);
      usage[rootLabelId] = ids;
    });
    trimUsage(usage);
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
    const exercise = this.values;
    const usage = this.getSelectedLabels();
    trimUsage(usage);
    const data = new FormData();
    data.append('name', exercise.name);
    data.append('springs', exercise.springs);
    data.append('description', exercise.description);
    data.append('photo', exercise.photo);
    data.append('video', exercise.video);
    data.append('usage', JSON.stringify(usage));
    if (mode === MODE.EDIT && editItem) {
      data.append('id', editItem.id);
    }
    this.setState({ isSaving: true });
    return axios.post(`/exercise/${mode}`, data, {
      headers: { 'content-type': 'multipart/form-data' }
    }).then(res => {
      setTimeout(() => {
        exercise.id = res.data.id;
        exercise.revision = res.data.revision;
        if (res.data.photo) {
          exercise.photo = res.data.photo;
        }
        this.setState({ open: false, isSaving: false });
        this.props.onClose();
        if (mode === MODE.ADD) {
          this.props.onAdded(exercise, usage);
        } else {
          this.props.onSaved(exercise, usage);
        }
      }, ACCEPT_DELAY);
    }).catch(() => {
      this.setState({ error: ERROR.SAVE, isSaving: false });
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

  handleNameChange = e => {
    this.setState({ exerciseName: e.target.value });
  };

  render () {
    const { classes } = this.props;
    const { exerciseName } = this.state;

    return (
      <Dialog
          open={this.state.open}
          onClose={this.handleClose}
          aria-labelledby="form-dialog-title"
          maxWidth="md"
          disableEscapeKeyDown={true}
          disableBackdropClick={true}
        >
        <AppBar position="static">
          <Typography variant="title" color="inherit" className={classes.flex}>
          <Input fullWidth={true} defaultValue={exerciseName} classes={{ root: classes.title }} onChange={this.handleNameChange} />
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
    const { error, isSaving } = this.state;
    const { classes, labels, editItem } = this.props;
    const hasError = !!error;
    const defaultItem = this.defaultItem;
    
    return (
      <div>
        <DialogContent className={classes.content}>
        <Grid container spacing={24}>
          <Grid item xs={1} sm={7}>
              <FormLabel className={css(classes.descLabel, classes.topLabel)} component="legend">Description</FormLabel>
              <div className={classes.editor} >
                <Editor
                  editorState={this.state.editorState}
                  handleKeyCommand={this.handleEditorKeyCommand}
                  onChange={this.onChange} />
              </div>
              <TextField
                margin="dense"
                id="addEdit_springs"
                label="Springs"
                type="text"
                fullWidth
                defaultValue={defaultItem.springs}
              />
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
          <Grid item xs={1} sm={5}>
            <ExerciseLabels onChange={this.handleExerciseLabelChange} usage={editItem && editItem.usage} labels={labels} />
          </Grid>
        </Grid>
      </DialogContent>
      <DialogActions className={classes.actions}>
        <Button onClick={this.handleClose} color="primary" disabled={isSaving}>
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

export default withStyles(theme => ({
  descLabel: {
    marginTop: theme.spacing.unit * 3,
    marginBottom: theme.spacing.unit,
  },
  topLabel: {
    marginTop: 0,
  },
  editor: {
    border: '1px solid #b2b2b2',
    borderRadius: '5px',
    padding: '5px',
    fontSize: '80%',
    maxHeight: 259,
    height: 259,
    overflow: 'auto',
  },
  flex: {
    padding: '0 10px',
    flex: 1,
  },
  content: {
    flexGrow: 1,
    width: 700,
  },
  snackbar: {
    position: 'absolute',
  },
  snackbarContent: {
    width: 360,
  },
  title: {
    fontSize: '100%',
    flexGrow: 1,
    color: '#fff',
  },
  actions: {
    marginTop: -40,
  }
}))(AddEdit);