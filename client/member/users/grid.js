import * as React from 'react';
import PropTypes from 'prop-types';
import Paper from 'material-ui/Paper';
import {
  SortingState, SelectionState, FilteringState, SearchState,
  IntegratedFiltering, IntegratedSorting, IntegratedSelection,
  DataTypeProvider,
} from '@devexpress/dx-react-grid';
import {
  Grid,
  VirtualTable, TableHeaderRow, TableFilterRow, TableSelection,
  DragDropProvider, TableColumnReordering, Toolbar, SearchPanel,
  ColumnChooser, TableColumnVisibility, TableColumnResizing,
} from '@devexpress/dx-react-grid-material-ui';
import Button from 'material-ui/Button';
import AddIcon from 'material-ui-icons/Add';
import EditIcon from 'material-ui-icons/Edit';
import DeleteIcon from 'material-ui-icons/Delete';
import PasswordIcon from 'material-ui-icons/VpnKey';
import PermissionForbiddenIcon from 'material-ui-icons/Block';
import PermissionReadIcon from 'material-ui-icons/RadioButtonUnchecked';
import PermissionReadWriteIcon from 'material-ui-icons/AddCircleOutline';
import PermissionReadWriteDeleteIcon from 'material-ui-icons/AddCircle';
import Tooltip from 'material-ui/Tooltip';
import { LinearProgress } from 'material-ui/Progress';
import { withStyles } from 'material-ui/styles';
import axios from 'axios';
import AddSelect from './addSelect';
import AddEdit from './addEdit';
import Alert from '../../common/alert';
import { permissions } from '../session';

const Cell = (props) => {
  return <VirtualTable.Cell {...props} />;
};

const getRowId = row => row.id;

const MODE = {
  LOADING: 'loading',
  READ: 'read',
  ADD: 'add',
  EDIT: 'edit',
  SET_PASSWORD: 'set_password',
  CONFIRM_DELETE: 'confirm_delete',
};

const KEYS = {
  OPTION: 18,
  ENTER: 13,
  SPACE: 32,
  UP: 38,
  DOWN: 40,
  TILDA: 192,
  META: 'Meta',
};

const PERMISSION_ICONS = {
  0: PermissionForbiddenIcon,
  1: PermissionReadIcon,
  2: PermissionReadWriteIcon,
  3: PermissionReadWriteDeleteIcon,
};

const PERMISSION_TEXT = {
  0: 'Forbidden',
  1: 'Read Only',
  2: 'Read/Write',
  3: 'Read/Write/Delete',
};

const PERMISSION_TYPE = {
  0: 'Exercises',
  1: 'Classes',
  2: 'Users',
};

const PermissionFormatter = ({ row }) => {
  const rowPermissions = '' + row.permissions;
  const icons = [];
  for (let i = 0; i < 3; i++) {
    const permissionValue = rowPermissions.charAt(i);
    const CLS = PERMISSION_ICONS[permissionValue];
    icons.push(<Tooltip title={`${PERMISSION_TYPE[i]}: ${PERMISSION_TEXT[permissionValue]}`} key={`${i}permi${rowPermissions.charAt(i)}`}><CLS /></Tooltip>);
  }
  return <span>{icons}</span>;
};

const PermissionTypeProvider = props => (
  <DataTypeProvider
    formatterComponent={PermissionFormatter}
    {...props}
  />
);

const DateFormatter = ({ row }) => {
  return <span>{new Date(Date.parse(row.lastLogin)).toLocaleString()}</span>;
};

const DateTypeProvider = props => (
  <DataTypeProvider
    formatterComponent={DateFormatter}
    {...props}
  />
);

const calcGridHeight = () => window.innerHeight - 230;

let defaultColumnWidths = [
  { columnName: 'firstName', width: 100 },
  { columnName: 'lastName', width: 100 },
  { columnName: 'email', width: 300 },
  { columnName: 'permissions', width: 100 },
  { columnName: 'lastLogin', width: 100 },
];

function setColumnWidths (nextColumnWidths) {
  const widths = {};
  defaultColumnWidths.forEach(info => widths[info.columnName] = info.width);
  nextColumnWidths.forEach(info => widths[info.columnName] = info.width);
  defaultColumnWidths = [];
  for (let k in widths) {
    defaultColumnWidths.push({ columnName: k, width: widths[k] });
  }
}

let defaultHiddenColumnNames = [];

try {
  defaultColumnWidths = JSON.parse(
    localStorage["phoenix_lib_1.0.users.column.width"]
  );
} catch (e) {}

try {
  defaultHiddenColumnNames = JSON.parse(
    localStorage["phoenix_lib_1.0.users.column.hidden"]
  );
} catch (e) {}

class UsersGrid extends React.Component {
  state = {
    mode: MODE.LOADING,
    columns: [
      { name: 'firstName', title: 'First Name' },
      { name: 'lastName', title: 'Last Name' },
      { name: 'email', title: 'Email' },
      { name: 'permissions', title: 'Permissions' },
      { name: 'lastLogin', title: 'Last Login' },
    ],
    rows: [],
    filteringStateColumnExtensions: [
      // { columnName: 'photo', filteringEnabled: false },
    ],
    defaultHiddenColumnNames,
    defaultColumnWidths,
    dateColumns: ['lastLogin'],
    permissionColumns: ['permissions'],
    selection: [],
    editItem: null,
    selectedGenre: null,
    program: null,
    gridHeight: calcGridHeight(),
  };

  async componentWillMount () {
    const { data } = await axios.get('/users/get');

    this.setState({
      mode: MODE.READ,
      rows: data,
      selection: [],
    });
    
    this.isMetaDown = false;

    window.addEventListener('keydown', this.onGlobalKeyDown);
    window.addEventListener('keyup', this.onGlobalKeyUp);
    window.addEventListener('resize', this.onResize);
  }

  componentWillUnmount () {
    window.removeEventListener('keydown', this.onGlobalKeyDown);
    window.removeEventListener('keyup', this.onGlobalKeyUp);
    window.removeEventListener('resize', this.onResize);
  }

  onGlobalKeyDown = e => {
    if (e.key === 'Meta') {
      this.isMetaDown = true;
    }
  };

  onGlobalKeyUp = e => {
    const { keyCode, key } = e;
    const { selection, rows } = this.state;
    // const { isAdmin } = this.props;
    const ids = rows.map(row => row.id);
    ids.sort();
    if (key === KEYS.META) {
      this.isMetaDown = false;
    } else if ((keyCode === KEYS.TILDA) && this.state.selection.length === 1) {
      // const row = this.state.rows.find(row => row.id === this.state.selection[0]);
      // if (!isAdmin) {
      //   try {
      //     fscreen.requestFullscreen(document.documentElement);
      //   } catch (e) {
          
      //   }
      //   this.setState({ mode: MODE.VIEW, viewItem: row });
      // } else {
      //   this.setState({ mode: MODE.EDIT, editItem: row });
      // }
    } else if (selection.length === 1 && keyCode === KEYS.UP) {
      const selectedRowIndex = ids.indexOf(selection[0]);
      if (selectedRowIndex > 0) {
        this.setState({ selection: [ids[selectedRowIndex + 1]] });
      }
    } else if (selection.length === 1 && keyCode === KEYS.DOWN) {
      const selectedRowIndex = ids.indexOf(selection[0]);
      if (selectedRowIndex <= ids.length - 1) {
        this.setState({ selection: [ids[selectedRowIndex - 1]] });
      }
    }
  };

  onResize = () => {
    this.setState({ gridHeight: calcGridHeight() });
  };

  onAddClick = () => {
    axios.get('/label/get/0').then(response => {
      this.setState({ genres: response.data, mode: MODE.ADD_SELECT });
    });
  };

  onEditClick = () => {
    const row = this.state.rows.find(row => row.id === this.state.selection[0]);
    this.setState({
      mode: MODE.EDIT,
      editItem: row,
    });
  };

  onDeleteClick = () => {
    this.setState({ mode: MODE.CONFIRM_DELETE });
  };

  onAddEditClose = () => {
    this.setState({ mode: MODE.READ });
  };

  onAddSelectClose = async value => {
    if (value) {
      const { data: template } = await axios.get(`/template/${value}`);
      template.forEach(category => category.expanded = false);
      this.setState({
        selectedGenre: {
          id: value,
          name: this.state.genres.find(genre => genre.id === value).name,
        },
        mode: MODE.ADD,
        program: template,
        editItem: null,
      });
    } else {
      this.setState({ mode: MODE.READ });
    }
  };

  onViewClose = () => {
    this.setState({ mode: MODE.READ });
  };

  onConfirmDeleteClose = async didAccept => {
    if (didAccept) {
      const ids = this.state.selection;
      await axios.post('/class/delete', { ids: ids });
      const rows = this.state.rows.filter(row => ids.indexOf(row.id) === -1);
      this.setState({ rows, selection: [] });
    }
    this.setState({ mode: MODE.READ });
  };

  onSelectionChange = selection => {
    // const { selection: selected } = this.state;
    // const { isMetaDown } = this;
    // let viewItem;
    // let mode = MODE.READ;
    // if (!this.props.isAdmin) {
    //   if (!selection.length) {
    //     selection = selected;
    //   }
    //   for (let i = 0; i < selection.length; i++) {
    //     if (selected.indexOf(selection[i]) === -1) {
    //       selection = [selection[i]];
    //       break;
    //     }
    //   }
    //   try {
    //     fscreen.requestFullscreen(document.documentElement);
    //   } catch (e) {

    //   }
    //   mode = MODE.VIEW;
    // } else if (!isMetaDown) {
    //   for (let i = 0; i < selection.length; i++) {
    //     if (selected.indexOf(selection[i]) === -1) {
    //       selection = [selection[i]];
    //       break;
    //     }
    //   }
    // }
    // viewItem = this.state.rows.find(row => row.id === selection[0]);
    this.setState({ selection });
  };

  onAdded = (cls) => {
    const rows = [
      ...this.state.rows,
    ];
    rows.push(cls);
    this.setState({ rows, selection: [cls.id], mode: MODE.READ });
  };

  onSaved = (cls) => {
    const rows = [
      ...this.state.rows,
    ];
    const row = rows.find(row => row.id === cls.id);
    const index = rows.indexOf(row);
    rows.splice(index, 1);
    rows.splice(index, 0, cls);
    this.setState({ rows, editItem: null, selection: [], mode: MODE.READ });
  };

  onColumnWidthsChange = nextColumnWidths => {
    try {
      setColumnWidths(nextColumnWidths);
      const data = JSON.stringify(defaultColumnWidths);
      localStorage['phoenix_lib_1.0.users.column.width'] = data;
    } catch (e) {
      // ?
    }   
  };

  onHiddenColumnNamesChange = hiddenColumnNames => {
    try {
      const data = JSON.stringify(hiddenColumnNames);
      localStorage['phoenix_lib_1.0.users.column.hidden'] = data;
    } catch (e) {
      // ?
    }   
  };

  onSetPasswordClick = () => {
    this.setState({ mode: MODE.SET_PASSWORD });
  };

  renderEditControls () {
    const { selection, rows } = this.state;
    const { classes, isAdmin } = this.props;
    const canEdit = selection.length === 1 && (permissions.canDeleteClass 
      || rows.find(row => row.id === selection[0]).status === STATUSES.SUBMITTED);

    return (
      <span className={classes.root}>
      {
        isAdmin
          ? (
            <span>
              <Button variant="fab" color="primary" aria-label="add" className={classes.button} onClick={this.onAddClick}>
                <AddIcon />
              </Button>
              <Button variant="fab" aria-label="edit" disabled={!canEdit} className={classes.button} onClick={this.onEditClick}>
                <EditIcon />
              </Button>
              {
                permissions.canDeleteClass
                  ? <Button variant="fab" color="secondary" disabled={selection.length === 0} aria-label="delete" className={classes.button} onClick={this.onDeleteClick}>
                      <DeleteIcon />
                    </Button>
                  : null
              }
              <Button variant="fab" disabled={selection.length === 0} aria-label="password" className={classes.button} onClick={this.onSetPasswordClick}>
                <PasswordIcon />
              </Button>
            </span>
          )
          : null
      }
      </span>
    );
  }

  render () {
    const { 
      rows,
      columns, 
      tableColumnExtensions, 
      filteringStateColumnExtensions,
      defaultHiddenColumnNames,
      defaultColumnWidths,
      mode,
      dateColumns,
      permissionColumns,
      selection,
      program,
      editItem,
      genres,
      selectedGenre,
      gridHeight,
    } = this.state;

    const { isAdmin, classes } = this.props;

    if (mode === MODE.LOADING) {
      return (
        <Paper>
          <LinearProgress classes={{ colorPrimary: classes.progressFG, barColorPrimary: classes.progressBG }} />
        </Paper>
      );
    };

    return (
      <Paper id="grid">
        { this.renderEditControls() }
        <Grid rows={rows} columns={columns} getRowId={getRowId}>
          <PermissionTypeProvider for={permissionColumns} />
          <DateTypeProvider for={dateColumns} />
          <DragDropProvider />
          <FilteringState columnExtensions={filteringStateColumnExtensions} />
          <SearchState />
          <SortingState
            defaultSorting={[
              { columnName: 'id', direction: 'desc' },
              { columnName: 'name', direction: 'asc' },
              { columnName: 'status', direction: 'asc' },
              { columnName: 'genre', direction: 'asc' },
              { columnName: 'designer', direction: 'asc' },
            ]}
          />
          <SelectionState selection={selection} onSelectionChange={this.onSelectionChange} />
          <IntegratedFiltering />
          <IntegratedSorting />
          <IntegratedSelection />
          <VirtualTable columnExtensions={tableColumnExtensions} cellComponent={Cell} height={gridHeight} />
          {<TableColumnResizing defaultColumnWidths={defaultColumnWidths} onColumnWidthsChange={this.onColumnWidthsChange} />}
          <TableHeaderRow showSortingControls />
          <TableColumnReordering defaultOrder={columns.map(column => column.name)} />
          <TableFilterRow />
          <TableSelection showSelectAll={isAdmin} highlightRow selectByRowClick showSelectionColumn={isAdmin} />
          <TableColumnVisibility defaultHiddenColumnNames={defaultHiddenColumnNames} onHiddenColumnNamesChange={this.onHiddenColumnNamesChange} />
          <Toolbar />
          <ColumnChooser />
          <SearchPanel />
        </Grid>
        {
          mode === MODE.ADD_SELECT
            ? <AddSelect genres={genres} onClose={this.onAddSelectClose} />
            : null
        }
        {
          mode === MODE.ADD || mode === MODE.EDIT
            ? <AddEdit mode={mode} genreId={(editItem && editItem.genreId) || selectedGenre.id} program={program} className={mode === MODE.ADD ? `New ${selectedGenre.name} Class` : editItem.name} editItem={editItem} onAdded={this.onAdded} onSaved={this.onSaved} onClose={this.onAddEditClose} />
            : null
        }
        {
          mode === MODE.CONFIRM_DELETE
          ? <Alert 
              title="Confirm Delete" 
              message={`Do you really want to delete ${selection.length === 1 ? 'this class' : 'these ' + selection.length + ' classes'}?`}
              submitText="Delete" 
              onClose={this.onConfirmDeleteClose} 
            />
          : null
        }
      </Paper>
    );
  }
}

UsersGrid.propTypes = {
  classes: PropTypes.object.isRequired,
};

export default withStyles(theme => ({
  root: {
    position: 'absolute',
    zIndex: 1100,
  },
  '&:tr': {
    cursor: 'pointer',
  },
  button: {
    margin: theme.spacing.unit,
    width: 45,
    height: 45,
  },
  count: {
    display: 'inline-block',
    marginLeft: 10,
    color: '#ccc',
  },
  pointer: {
    cursor: 'pointer',
  },
  progressFG: {
    backgroundColor: '#2aff48',
  },
  progressBG: {
    backgroundColor: '#fff',
  },
}))(UsersGrid);