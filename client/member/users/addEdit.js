import React, { Fragment } from 'react';
import Button from 'material-ui/Button';
import TextField from 'material-ui/TextField';
import { MenuItem } from 'material-ui/Menu';
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
import { clone } from '../../common/util';
import PermissionForbiddenIcon from 'material-ui-icons/Block';
import PermissionReadIcon from 'material-ui-icons/RadioButtonUnchecked';
import PermissionReadWriteIcon from 'material-ui-icons/AddCircleOutline';
import PermissionReadWriteDeleteIcon from 'material-ui-icons/AddCircle';

const ACCEPT_DELAY = 500;

const ICONS = {
  0: <PermissionForbiddenIcon />,
  1: <PermissionReadIcon />,
  2: <PermissionReadWriteIcon />,
  3: <PermissionReadWriteDeleteIcon />
};

const MODE = {
  ADD: 'add',
  EDIT: 'edit',
};

class AddEdit extends React.Component {
  state = {
    open: true,
    user: null,
    isSaving: false,
    exerciseLevel: -1,
    classLevel: -1,
    userLevel: -1,
    isValid: false,
  };

  componentDidMount () {
    const user = (this.props.user && clone(this.props.user)) || this.defaultItem;
    user.password = '';
    this.setState({
      user,
      exerciseLevel: parseFloat(user.permissions.charAt(0)),
      classLevel: parseFloat(user.permissions.charAt(1)),
      userLevel: parseFloat(user.permissions.charAt(2)),
      isValid: this.props.mode === 'add' ? false : true
    });
  }

  get defaultItem () {
    return {
      firstName: '',
      lastName: '',
      email: '',
      password: '',
      permissions: '110',
    };
  }

  handleSave = async () => {
    const { mode, onAdded, onSaved } = this.props;
    const { exerciseLevel, classLevel, userLevel, user: usr } = this.state;

    const firstName = document.getElementById('firstName').value.trim();
    const lastName = document.getElementById('lastName').value.trim();
    const email = document.getElementById('email').value.trim();
    const password = document.getElementById('password').value.trim();
    const permissions = `${exerciseLevel}${classLevel}${userLevel}`;

    const user = {
      id: usr.id,
      firstName,
      lastName,
      email,
      password,
      permissions,
    };

    const close = () => {
      setTimeout(() => {
        if (mode === MODE.ADD) {
          onAdded(user);
        } else {
          onSaved(user);
        }
      }, ACCEPT_DELAY);
      return Promise.resolve();
    };

    try {
      this.setState({ isSaving: true });
      const response = await axios.post(`/user/${mode}`, user);
      if (mode === 'add') {
        user.id = response.data.id;
      }
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

  handleExerciseLevelChange = e => {
    this.setState({ exerciseLevel: e.target.value });
  };

  handleClassLevelChange = e => {
    this.setState({ classLevel: e.target.value });
  };

  handleUserLevelChange = e => {
    this.setState({ userLevel: e.target.value });
  };

  handleTextChange = () => {
    const { mode } = this.props;
    const firstName = document.getElementById('firstName').value.trim();
    const lastName = document.getElementById('lastName').value.trim();
    const email = document.getElementById('email').value.trim();
    const password = document.getElementById('password').value.trim();
    this.setState({ isValid: !!(firstName && lastName && email && (mode === 'add' ? !!password : true)) });
  };

  render () {
    const { user } = this.state;
    const { classes, mode } = this.props;

    if (!user) {
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
            <Input fullWidth={true} defaultValue={`${mode === 'add' ? 'Add' : 'Edit'} User`} classes={{ root: classes.title }} readOnly />
          </Typography>
        </AppBar>

        { this.renderContent() }
        
      </Dialog>
    );
  }

  renderContent () {
    const { isSaving, user, exerciseLevel, classLevel, userLevel, isValid } = this.state;
    const { classes } = this.props;

    return (
      <Fragment>
        <DialogContent className={classes.content}>
          <Grid container spacing={24}>
          <Grid item xs={6}>
                <TextField
                  margin="dense"
                  id="firstName"
                  label="First Name"
                  type="text"
                  fullWidth
                  defaultValue={user.firstName}
                  onChange={this.handleTextChange}
                />
              </Grid>
              <Grid item xs={6}>
                <TextField
                  margin="dense"
                  id="lastName"
                  label="Last Name"
                  type="text"
                  fullWidth
                  defaultValue={user.lastName}
                  onChange={this.handleTextChange}
                />
              </Grid>
              <Grid item xs={6}>
                <TextField
                  margin="dense"
                  id="email"
                  label="Email"
                  type="text"
                  fullWidth
                  defaultValue={user.email}
                  onChange={this.handleTextChange}
                />
              </Grid>
              <Grid item xs={6}>
                <TextField
                  margin="dense"
                  id="password"
                  label="Password"
                  type="text"
                  fullWidth
                  defaultValue={user.password}
                  onChange={this.handleTextChange}
                  disabled={!!this.props.user}
                />
              </Grid>
              <Grid item xs={4}>
                <div>
                  <FormLabel component="legend">Exercise Permissions</FormLabel>
                  <Select
                    value={exerciseLevel}
                    onChange={this.handleExerciseLevelChange}
                    input={<Input name="exerciseLevel" id="exerciseLevel" />}
                  >
                    <MenuItem value={3}>Read / Write / Delete</MenuItem>
                    <MenuItem value={2}>Read / Write</MenuItem>
                    <MenuItem value={1}>Read</MenuItem>
                    <MenuItem value={0}>Forbidden</MenuItem>
                  </Select>
                </div>
              </Grid>
              <Grid item xs={4}>
                <div>
                  <FormLabel component="legend">Class Permissions</FormLabel>
                  <Select
                    value={classLevel}
                    onChange={this.handleClassLevelChange}
                    input={<Input name="classLevel" id="classLevel" />}
                  >
                    <MenuItem value={3}>Read / Write / Delete</MenuItem>
                    <MenuItem value={2}>Read / Write</MenuItem>
                    <MenuItem value={1}>Read</MenuItem>
                    <MenuItem value={0}>Forbidden</MenuItem>
                  </Select>
                </div>
              </Grid>
              <Grid item xs={4}>
                <div>
                  <FormLabel component="legend">User Permissions</FormLabel>
                  <Select
                    value={userLevel}
                    onChange={this.handleUserLevelChange}
                    input={<Input name="userLevel" id="userLevel" />}
                  >
                    <MenuItem value={3}>Read / Write / Delete</MenuItem>
                    <MenuItem value={2}>Read / Write</MenuItem>
                    <MenuItem value={1}>Read</MenuItem>
                    <MenuItem value={0}>Forbidden</MenuItem>
                  </Select>
                </div>
              </Grid>
              <Grid item xs={12}>
                {ICONS[exerciseLevel]}
                {ICONS[classLevel]}
                {ICONS[userLevel]}
              </Grid>
          </Grid>
        </DialogContent>
        <DialogActions classes={{ root: classes.actions }}>
          <Button onClick={this.handleClose} color="primary" disabled={isSaving}>
            Cancel
          </Button>
          <SaveButton onClick={this.handleSave} disabled={!isValid} />
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
  topLabel: {
    marginTop: 0,
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
  },
  icon: {
    display: 'block',
  }
}))(AddEdit);