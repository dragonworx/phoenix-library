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
import Tooltip from 'material-ui/Tooltip';
import { LinearProgress } from 'material-ui/Progress';
import { withStyles } from 'material-ui/styles';
import axios from 'axios';
import AddSelect from './addSelect';
import AddEdit from './addEdit';
import ViewClass from './view';
import Alert from '../../common/alert';

const Cell = (props) => {
  return <VirtualTable.Cell {...props} />;
};

const getRowId = row => row.id;

const MODE = {
  LOADING: 'loading',
  READ: 'read',
  ADD_SELECT: 'add_select',
  ADD: 'add',
  EDIT: 'edit',
  VIEW: 'view',
  CONFIRM_DELETE: 'confirm_delete',
};

const KEYS = {
  OPTION: 18,
  ENTER: 13,
  SPACE: 32,
  UP: 38,
  DOWN: 40,
  TILDA: 192,
};

const htmlNode = document.createElement('div');

const NameFormatter = ({ row }) => {
  return <Tooltip title={row.name}><label><span style={{ fontSize: '80%', color: '#ccc', marginRight: 2 }}>#{row.id}.</span>{row.name}</label></Tooltip>;
};

const NameTypeProvider = props => (
  <DataTypeProvider
    formatterComponent={NameFormatter}
    {...props}
  />
);

const HTMLFormatter = ({ value }) => {
  htmlNode.innerHTML = value;
  return <Tooltip title={htmlNode.textContent} placement="top"><span>{htmlNode.textContent}</span></Tooltip>;
};

const HTMLTypeProvider = props => (
  <DataTypeProvider
    formatterComponent={HTMLFormatter}
    {...props}
  />
);

const DurationFormatter = ({ value }) => {
  return <span>{value} mins</span>;
};

const DurationTypeProvider = props => (
  <DataTypeProvider
    formatterComponent={DurationFormatter}
    {...props}
  />
);

const TooltipFormatter = ({ value }) => {
  if (value) {
    const values = Array.isArray(value) ? value.join(', ') : String(value);
    return <Tooltip title={values} placement="top"><span>{values}</span></Tooltip>;
  }
  return null;
};

const TooltipTypeProvider = props => (
  <DataTypeProvider
    formatterComponent={TooltipFormatter}
    {...props}
  />
);

let defaultColumnWidths = [
  { columnName: 'name', width: 300 },
  { columnName: 'genre', width: 100 },
  { columnName: 'categorySummary', width: 100 },
  { columnName: 'durationSummary', width: 100 },
  { columnName: 'status', width: 200 },
  { columnName: 'notes', width: 200 },
];

try {
  defaultColumnWidths = JSON.parse(localStorage['phoenix_lib_2.columns']);
} catch (e) {
  console.warn('Could not load column widths: ' + String(e));
}

class ClassesGrid extends React.PureComponent {
  state = {
    mode: MODE.LOADING,
    columns: [
      { name: 'name', title: 'Name' },
      { name: 'genre', title: 'Genre', getCellValue: row => ClassesGrid.labels.find(label => label.id = row.genreId).name },
      { name: 'categorySummary', title: 'Movement Cats.' },
      { name: 'durationSummary', title: 'Duration' },
      { name: 'status', title: 'Status' },
      { name: 'notes', title: 'Notes' },
    ],
    rows: [],
    filteringStateColumnExtensions: [
      // { columnName: 'photo', filteringEnabled: false },
    ],
    defaultHiddenColumnNames: ['notes'],
    defaultColumnWidths,
    nameColumns: ['name'],
    tooltipColumns: ['name', 'categorySummary', 'notes'],
    htmlColumns: ['notes'],
    durationColumns: ['durationSummary'],
    selection: [],
    editItem: null,
    viewItem: null,
    selectedGenre: null,
    program: null,
  };

  async componentWillMount () {
    const { data: classes } = await axios.get('/classes/get');
    const { data: labels } = await axios.get('/labels/get');
    ClassesGrid.labels = labels;
    this.setState({
      mode: MODE.READ,
      rows: classes,
      selection: [],
    });
    
    this.isCommandDown = false;
    window.addEventListener('keydown', this.onGlobalKeyDown);
    window.addEventListener('keyup', this.onGlobalKeyUp);
  }

  componentWillUnmount () {
    window.removeEventListener('keydown', this.onGlobalKeyDown);
    window.removeEventListener('keyup', this.onGlobalKeyUp);
  }

  onGlobalKeyDown = e => {
    if (e.keyCode === KEYS.OPTION) {
      this.isCommandDown = true;
    }
  };

  onGlobalKeyUp = e => {
    const { keyCode } = e;
    const { selection, rows } = this.state;
    const { readOnly } = this.props;
    const ids = rows.map(row => row.id);
    ids.sort();
    if (keyCode === KEYS.OPTION) {
      this.isCommandDown = false;
    } else if ((keyCode === KEYS.TILDA) && this.state.selection.length === 1) {
      const row = this.state.rows.find(row => row.id === this.state.selection[0]);
      if (readOnly) {
        this.setState({ mode: MODE.VIEW, viewItem: row });
      } else {
        this.setState({ mode: MODE.EDIT, editItem: row });
      }
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
    this.setState({ mode: MODE.READ, viewItem: null });
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
    const { selection: selected } = this.state;
    const { isCommandDown } = this;
    let viewItem;
    let mode = MODE.READ;
    if (this.props.readOnly) {
      if (!selection.length) {
        selection = selected;
      }
      for (let i = 0; i < selection.length; i++) {
        if (selected.indexOf(selection[i]) === -1) {
          selection = [selection[i]];
          break;
        }
      }
      viewItem = this.state.rows.find(row => row.id === selection[0]);
      mode = MODE.VIEW;
    } else if (!isCommandDown) {
      for (let i = 0; i < selection.length; i++) {
        if (selected.indexOf(selection[i]) === -1) {
          selection = [selection[i]];
          break;
        }
      }
    }
    this.setState({ selection, viewItem, mode });
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
      const data = JSON.stringify(nextColumnWidths);
      localStorage['phoenix_lib_2.columns'] = data;
    } catch (e) {
      // ?
    }   
  };

  renderEditControls () {
    const { selection } = this.state;
    const { classes, readOnly } = this.props;

    return (
      <span className={classes.root}>
      {
        readOnly
          ? null
          : (
            <span>
              <Button variant="fab" color="primary" aria-label="add" className={classes.button} onClick={this.onAddClick}>
                <AddIcon />
              </Button>
              <Button variant="fab" aria-label="edit" disabled={selection.length !== 1} className={classes.button} onClick={this.onEditClick}>
                <EditIcon />
              </Button>
              <Button variant="fab" color="secondary" disabled={selection.length === 0} aria-label="delete" className={classes.button} onClick={this.onDeleteClick}>
                <DeleteIcon />
              </Button>
            </span>
          )
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
      htmlColumns,
      durationColumns,
      tooltipColumns,
      nameColumns,
      selection,
      program,
      editItem,
      viewItem,
      genres,
      selectedGenre,
    } = this.state;

    const { readOnly } = this.props;

    if (mode === MODE.LOADING) {
      return (
        <Paper>
          <LinearProgress />
        </Paper>
      );
    };

    return (
      <Paper>
        { this.renderEditControls() }
        <Grid rows={rows} columns={columns} getRowId={getRowId}>
          <NameTypeProvider for={nameColumns} />
          <TooltipTypeProvider for={tooltipColumns} />
          <HTMLTypeProvider for={htmlColumns} />
          <DurationTypeProvider for={durationColumns} />
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
          <VirtualTable columnExtensions={tableColumnExtensions} cellComponent={Cell} height={615} />
          {<TableColumnResizing defaultColumnWidths={defaultColumnWidths} onColumnWidthsChange={this.onColumnWidthsChange} />}
          <TableHeaderRow showSortingControls />
          <TableColumnReordering defaultOrder={columns.map(column => column.name)} />
          <TableFilterRow />
          <TableSelection showSelectAll={!readOnly} highlightRow selectByRowClick showSelectionColumn={!readOnly} />
          <TableColumnVisibility defaultHiddenColumnNames={defaultHiddenColumnNames} />
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
          mode === MODE.VIEW
            ? <ViewClass viewItem={viewItem} onClose={this.onViewClose} />
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

ClassesGrid.propTypes = {
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
  },
  count: {
    display: 'inline-block',
    marginLeft: 10,
    color: '#ccc',
  },
  pointer: {
    cursor: 'pointer',
  }
}))(ClassesGrid);