import React, { Fragment } from 'react';
import Button from 'material-ui/Button';
import Menu, { MenuItem } from 'material-ui/Menu';
import { Editor, EditorState, RichUtils } from 'draft-js';
import { stateToHTML } from 'draft-js-export-html';
import { stateFromHTML } from 'draft-js-import-html';
import IconButton from "material-ui/IconButton";
import AddIcon from "material-ui-icons/AddCircle";
import ExpandMoreIcon from 'material-ui-icons/ExpandMore';
import ExpandLessIcon from 'material-ui-icons/ExpandLess';
import Dialog, {
  DialogActions,
  DialogContent,
} from 'material-ui/Dialog';
import { FormLabel } from 'material-ui/Form';
import Input from 'material-ui/Input';
import AppBar from 'material-ui/AppBar';
import Typography from 'material-ui/Typography';
import Grid from 'material-ui/Grid';
import Select from 'material-ui/Select';
import { withStyles } from "material-ui/styles";
import axios from 'axios';
import SaveButton from '../../common/saveButton';
import ClassProgram from './classProgram';
import { user, permissions } from '../session';

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
    addCategories: null,
    addCategoriesTarget: null,
    className: null,
    isSaving: false,
  };

  constructor (props) {
    super(props);
    this.state.program = props.program;
    this.state.className = props.className;
    this.saveCount = 0;
  }

  async componentWillMount () {
    const { editItem } = this.props;
    if (editItem) {
      const { data: program } = await axios.get(`/class/program/${editItem.id}`);
      program.forEach(category => category.expanded = false);
      const state = stateFromHTML(editItem.notes);
      this.setState({
        editorState: EditorState.createWithContent(state),
        className: editItem.name,
        program
      });
    }

    window.onbeforeunload = function() {
      return "Are you sure you want to navigate away?";
    };
  }

  componentWillUnmount () {
    window.onbeforeunload = null;
  }

  handleSave = async e => {
    const { genreId, mode, onAdded, onSaved, editItem } = this.props;
    const { editorState, program, className: className } = this.state;
    const notes = stateToHTML(editorState.getCurrentContent());

    const cls = {
      id: editItem && editItem.id,
      genreId: genreId,
      createdBy: user.id,
      name: className,
      categories: program,
      status: editItem ? editItem.status : 0,
      createdAt: editItem && editItem.createdAt,
      updatedAt: new Date(),
      notes,
    };

    const close = () => {
      setTimeout(() => {
        if (mode === MODE.ADD) {
          onAdded(cls);
        } else {
          onSaved(cls);
        }
      }, ACCEPT_DELAY);
      return Promise.resolve();
    };

    try {
      this.saveCount++;
      this.setState({ isSaving: true });
      const { data: { id, categorySummary, durationSummary, revision } } = await axios.post(`/class/${mode}`, cls);
      cls.id = id || cls.id;
      cls.categorySummary = categorySummary;
      cls.durationSummary = durationSummary;
      cls.revision = revision;
      this.setState({ isSaving: false });
    } catch (e) {
      this.setState({ isSaving: false });
      throw e;
    }

    return close();
  };

  handleClose = () => {
    this.setState({ open: false });
    setTimeout(() => this.props.onClose(), ACCEPT_DELAY);
  };

  handleChange = e => {
    this.setState({ value: e.target.value });
  };

  onChange = (editorState) => this.setState({editorState});

  onDeleteCategory = () => {
    const program = this.state.program;
    program.forEach((category, i) => category.index = i);
    this.setState({ program });
  };

  handleEditorKeyCommand = (command, editorState) => {
    const newState = RichUtils.handleKeyCommand(editorState, command);
    if (newState) {
      this.onChange(newState);
      return 'handled';
    }
    return 'not-handled';
  };

  handleAddCatClick = async e => {
    const target = e.target;
    const { data: addCategories } = await axios.get(`/class/categories/${this.props.genreId}`);
    this.setState({ addCategories, addCategoriesTarget: target });
  };

  handleCloseAddCategories = category => {
    if (category) {
      const program = this.state.program;
      const movementCat = {
        labelId: category.id, 
        name: category.name, 
        index: program.length, 
        exercises: [],
      };
      program.push(movementCat);
      this.setState({ program, addCategories: null, addCategoriesTarget: null });
    } else {
      this.setState({ addCategories: null, addCategoriesTarget: null });
    }
  };

  handleNameChange = e => {
    this.setState({ className: e.target.value });
  };

  onDurationChange = () => {
    this.setState({ program: this.state.program });
  };

  expandAll = () => {
    const { program } = this.state;
    program.forEach(category => category.expanded = true);
    this.setState({ program });
  };

  collapseAll = () => {
    const { program } = this.state;
    program.forEach(category => category.expanded = false);
    this.setState({ program });
  };

  handleStatusChange = e => {
    const value = e.target.value;
    this.props.editItem.status = value;
    this.setState({ value: this.state.value });
  };

  render () {
    const { classes } = this.props;
    const { className, program } = this.state;

    if (!program) {
      return null;
    }

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
            <Input fullWidth={true} defaultValue={className} classes={{ root: classes.title }} onChange={this.handleNameChange} />
          </Typography>
        </AppBar>

        { this.renderContent() }
        
      </Dialog>
    );
  }

  renderContent () {
    const { addCategories, addCategoriesTarget, isSaving, program } = this.state;
    const { classes, genreId, editItem } = this.props;
    const duration = program.reduce((duration, category) => duration + category.exercises.reduce((duration, exercise) => duration + exercise.duration, 0), 0);

    return (
      <Fragment>
        <DialogContent className={classes.content}>
          <Grid container spacing={24}>
            <Grid item xs={12} style={{ position: 'relative', paddingBottom: 0, paddingTop: 0 }}>
              <FormLabel className={classes.primaryDescLabel} component="legend">Movement Categories</FormLabel>
              <ClassProgram genreId={genreId} program={program} onDeleteCategory={this.onDeleteCategory} onDurationChange={this.onDurationChange} />
              <a title="Add a movement category">
                <IconButton variant="fab" color="primary" aria-label="add movement category" className={classes.addCat} onClick={this.handleAddCatClick}>
                  <AddIcon />
                </IconButton>
              </a>
              <div className={classes.buttons}>
                <a title="collapse all">
                  <IconButton variant="raised" color="primary" aria-label="collapse all" className={classes.button} onClick={this.collapseAll}>
                    <ExpandLessIcon />
                  </IconButton>
                </a>
                <a title="expand all">
                  <IconButton variant="raised" color="primary" aria-label="expand all" className={classes.button} onClick={this.expandAll}>
                    <ExpandMoreIcon />
                  </IconButton>
                </a>
              </div>
              <div className={classes.duration}>{duration} mins Total Duration</div>
              {
                addCategories
                  ? <Menu
                      anchorEl={addCategoriesTarget}
                      open={true}
                      onClose={() => this.handleCloseAddCategories()}
                    >
                      {
                        addCategories.map(category => <MenuItem key={`add-cat-${category.id}`} onClick={() => this.handleCloseAddCategories(category)}>{category.name}</MenuItem>)
                      }
                    </Menu>
                  : null
              }
            </Grid>
            <Grid item xs={12} style={{ paddingTop: 0 }}>
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
        <DialogActions classes={{ root: classes.actions }}>
          {
            editItem && permissions.canDeleteClass
              ? (
                <div style={{ position: 'absolute', left: 20 }}>
                  <FormLabel style={{ display: 'inline-block' }} component="legend">Status</FormLabel>
                  <Select
                    value={editItem.status}
                    onChange={this.handleStatusChange}
                    input={<Input name="status" id="status" />}
                  >
                    <MenuItem value={0}>Submitted</MenuItem>
                    <MenuItem value={1}>Enabled</MenuItem>
                    <MenuItem value={2}>Disabled</MenuItem>
                  </Select>
                </div>
              )
              : null
          }
          <Button onClick={this.handleClose} color="primary" disabled={isSaving}>
            Close
          </Button>
          <SaveButton onClick={this.handleSave} disabled={program && program.length === 0} />
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
    backgroundColor: '#f3f8fc',
  },
  primaryDescLabel: {
    marginTop: theme.spacing.unit * 3,
    marginBottom: theme.spacing.unit,
  },
  descLabel: {
    marginTop: theme.spacing.unit,
    marginBottom: theme.spacing.unit,
  },
  flex: {
    flex: 1,
    padding: '0 10px',
  },
  content: {
    flexGrow: 1,
    width: 700,
    paddingBottom: 0,
    overflow: 'hidden',
  },
  addCat: {
    position: 'absolute',
    top: 8,
    left: 163,
  },
  title: {
    fontSize: '100%',
    flexGrow: 1,
    color: '#fff',
  },
  duration: {
    bottom: -24,
		right: 18,
		color: '#84a0c0',
		position: 'absolute',
		fontSize: '80%',
  },
  buttons: {
    height: 20,
		textAlign: 'right',
		top: 11,
		right: 60,
		position: 'absolute',
  },
  actions: {
    margin: '10px 16px',
  }
}))(AddEdit);