import React, { Fragment } from 'react';
import Button from 'material-ui/Button';
import Menu, { MenuItem } from 'material-ui/Menu';
import { Editor, EditorState, RichUtils } from 'draft-js';
import { stateToHTML } from 'draft-js-export-html';
import { stateFromHTML } from 'draft-js-import-html';
import IconButton from "material-ui/IconButton";
import AddIcon from "material-ui-icons/AddCircle";
import Dialog, {
  DialogActions,
  DialogContent,
} from 'material-ui/Dialog';
import { FormLabel } from 'material-ui/Form';
import Input from 'material-ui/Input';
import AppBar from 'material-ui/AppBar';
import Typography from 'material-ui/Typography';
import Grid from 'material-ui/Grid';
import { withStyles } from "material-ui/styles";
import axios from 'axios';
import SaveButton from '../../common/saveButton';
import ClassProgram from './classProgram';
import { user } from '../session';

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
  }

  async componentWillMount () {
    const { editItem } = this.props;
    if (editItem) {
      const { data: program } = await axios.get(`/class/program/${editItem.id}`);
      const state = stateFromHTML(editItem.notes);
      this.setState({
        editorState: EditorState.createWithContent(state),
        className: editItem.name,
        program
      });
    }
  }

  handleSave = async () => {
    const { genreId, mode, onAdded, onSaved, editItem } = this.props;
    const { editorState, program, className: className } = this.state;
    const notes = stateToHTML(editorState.getCurrentContent());

    const cls = {
      id: editItem && editItem.id,
      genreId: genreId,
      createdBy: user.id,
      name: className,
      categories: program,
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
      this.setState({ isSaving: true });
      const { data: { id, categorySummary, durationSummary } } = await axios.post(`/class/${mode}`, cls);
      cls.id = id || cls.id;
      cls.categorySummary = categorySummary;
      cls.durationSummary = durationSummary;
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
    const { classes, genreId } = this.props;

    return (
      <Fragment>
        <DialogContent className={classes.content}>
          <Grid container spacing={24}>
            <Grid item xs={12} style={{ position: 'relative' }}>
              <FormLabel className={classes.primaryDescLabel} component="legend">Program</FormLabel>
              <ClassProgram genreId={genreId} program={program} onDeleteCategory={this.onDeleteCategory} />
              <IconButton variant="fab" color="primary" aria-label="add movement category" className={classes.addCat} onClick={this.handleAddCatClick}>
                <AddIcon />
              </IconButton>
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
          <Button onClick={this.handleClose} color="primary" disabled={isSaving}>
            Cancel
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
    backgroundColor: 'fcfcfc',
  },
  primaryDescLabel: {
    marginTop: theme.spacing.unit * 3,
    marginBottom: theme.spacing.unit,
  },
  descLabel: {
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
  addCat: {
    position: 'absolute',
    top: 20,
    left: 70,
  },
  title: {
    fontSize: '100%',
    flexGrow: 1,
    color: '#fff',
  }
}))(AddEdit);