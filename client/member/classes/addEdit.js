import React, { Fragment } from 'react';
import Button from 'material-ui/Button';
import Select from 'material-ui/Select';
import { MenuItem } from 'material-ui/Menu';
import { Editor, EditorState, RichUtils } from 'draft-js';
import { stateToHTML } from 'draft-js-export-html';
import { stateFromHTML } from 'draft-js-import-html';
import Dialog, {
  DialogActions,
  DialogContent,
} from 'material-ui/Dialog';
import { FormLabel } from 'material-ui/Form';
import AppBar from 'material-ui/AppBar';
import Typography from 'material-ui/Typography';
import Grid from 'material-ui/Grid';
import { withStyles } from "material-ui/styles";
import SaveButton from '../../common/saveButton';
import Program from './program';

const ACCEPT_DELAY = 500;

const MODE = {
  ADD: 'add',
  EDIT: 'edit',
};

class AddEdit extends React.Component {
  state = {
    open: true,
    editorState: EditorState.createEmpty(),
    value: 1,
    program: null,
  };

  constructor (props) {
    super(props);
    this.state.program = props.program;
  }

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

  onChange = (editorState) => this.setState({editorState});

  handleEditorKeyCommand = (command, editorState) => {
    const newState = RichUtils.handleKeyCommand(editorState, command);
    if (newState) {
      this.onChange(newState);
      return 'handled';
    }
    return 'not-handled';
  };

  render () {
    const { classes, mode, genre } = this.props;

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
            {mode === MODE.ADD ? 'New' : 'Edit'} {genre.name} Class
          </Typography>
        </AppBar>

        { this.renderContent() }
        
      </Dialog>
    );
  }

  renderContent () {
    const { } = this.state;
    const { classes, program, genre } = this.props;
    
    return (
      <Fragment>
        <DialogContent className={classes.content}>
          <Grid container spacing={24}>
            <Grid item xs={12}>
              <FormLabel className={classes.descLabel} component="legend">Program</FormLabel>
              <Program genreId={genre.id} program={program} />
            </Grid>
            <Grid item xs={12}>
              <FormLabel className={classes.descLabel} component="legend">Notes</FormLabel>
                <div className={classes.editor} >
                  <Editor
                    editorState={this.state.editorState}
                    handleKeyCommand={this.handleEditorKeyCommand}
                    onChange={this.onChange} />
                </div>
            </Grid>
          </Grid>
        </DialogContent>
        <DialogActions>
          <Button onClick={this.handleClose} color="primary">
            Cancel
          </Button>
          <SaveButton onClick={this.handleSave} />
        </DialogActions>
      </Fragment>
    );
  }
}

export default withStyles(theme => ({
  select: {
    width: '100%',
  },
  editor: {
    border: '1px solid #b2b2b2',
    borderRadius: 5,
    padding: 5,
    fontSize: '80%',
    height: 46,
    overflow: 'auto',
    backgroundColor: 'fcfcfc',
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
    width: 700,
  },
}))(AddEdit);