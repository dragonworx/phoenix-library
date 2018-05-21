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
import ViewIcon from 'material-ui-icons/Visibility';
import Tooltip from 'material-ui/Tooltip';
import { LinearProgress } from 'material-ui/Progress';
import { withStyles } from 'material-ui/styles';
import axios from 'axios';
import AddSelect from './addSelect';
import AddEdit from './addEdit';
import ViewClass from './view';
import Alert from '../../common/alert';
import { permissions } from '../session';
import fscreen from 'fscreen';

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
  META: 'Meta',
};

const STATUS = {
  0: 'Submitted',
  1: 'Enabled',
  2: 'Disabled',
};

const STATUSES = {
  SUBMITTED: 0,
  ENABLED: 1,
  DISABLED: 2,
};

const htmlNode = document.createElement('div');

const NameFormatter = ({ row }) => {
  return <Tooltip title={row.name}><label><span style={{ fontSize: '80%', color: '#ccc', marginRight: 2 }}>#{row.id}.</span><a href={`/class/${row.id}`} target="_blank" onClick={e => {
    window.open('/class/' + row.id);
    e.persist();
    e.preventDefault();
    e.cancel = true;
    e.stopPropagation();
    return false;
  }}>{row.name}</a></label></Tooltip>;
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
  return <span>{!!value ? `${value} mins` : 'Empty'}</span>;
};

const DurationTypeProvider = props => (
  <DataTypeProvider
    formatterComponent={DurationFormatter}
    {...props}
  />
);

const StatusFormatter = ({ value }) => {
  return <span>{STATUS[value]}</span>;
};

const StatusTypeProvider = props => (
  <DataTypeProvider
    formatterComponent={StatusFormatter}
    {...props}
  />
);

const GenreFormatter = ({ row }) => {
  return <span>{ClassesGrid.labels.find(label => label.id === row.genreId).name}</span>;
};

const GenreTypeProvider = props => (
  <DataTypeProvider
    formatterComponent={GenreFormatter}
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

const calcGridHeight = () => window.innerHeight - 230;

let defaultColumnWidths = [
  { columnName: 'name', width: 300 },
  { columnName: 'genre', width: 100 },
  { columnName: 'categorySummary', width: 100 },
  { columnName: 'durationSummary', width: 100 },
  { columnName: 'status', width: 200 },
  { columnName: 'notes', width: 200 },
  { columnName: 'revision', width: 50 },
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

let defaultHiddenColumnNames = ['notes'];

try {
  defaultColumnWidths = JSON.parse(
    localStorage["phoenix_lib_1.0.classes.column.width"]
  );
} catch (e) {}

class ClassesGrid extends React.Component {
  state = {
    mode: MODE.LOADING,
    columns: [
      { name: 'name', title: 'Name' },
      { name: 'genre', title: 'Genre' },
      { name: 'categorySummary', title: 'Movement Cats.' },
      { name: 'durationSummary', title: 'Duration' },
      { name: 'status', title: 'Status' },
      { name: 'notes', title: 'Notes' },
      { name: 'revision', title: 'Rev.' },
    ],
    integratedFilteringColumnExtensions: [
      { columnName: 'status', predicate: (rowValue, filter) => {
        return STATUS[rowValue].indexOf(filter.value) > -1;
      }},
    ],
    rows: [],
    filteringStateColumnExtensions: [
      // { columnName: 'photo', filteringEnabled: false },
    ],
    defaultHiddenColumnNames,
    defaultColumnWidths,
    nameColumns: ['name'],
    tooltipColumns: ['categorySummary', 'notes'],
    genreColumns: ['genre'],
    htmlColumns: ['notes'],
    durationColumns: ['durationSummary'],
    statusColumns: ['status'],
    selection: [],
    editItem: null,
    viewItem: null,
    selectedGenre: null,
    program: null,
    gridHeight: calcGridHeight(),
  };

  async componentWillMount () {
    const { isAdmin } = this.props;
    const { data } = await axios.get('/classes/get');
    let classes = data;
    if (!isAdmin) {
      classes = classes.filter(cls => cls.status !== STATUSES.DISABLED);
    }
    const { data: labels } = await axios.get('/labels/get');

    classes.forEach(cls => cls.categorySummary = cls.categorySummary.split(',').join(', '));
    ClassesGrid.labels = labels;

    this.setState({
      mode: MODE.READ,
      rows: classes,
      selection: [],
    });
    
    this.isMetaDown = false;

    window.addEventListener('keydown', this.onGlobalKeyDown);
    window.addEventListener('keyup', this.onGlobalKeyUp);
    window.addEventListener('resize', this.onResize);

    if (!isAdmin) {
      defaultHiddenColumnNames.push('status');
    }

    try {
      defaultHiddenColumnNames = JSON.parse(
        localStorage["phoenix_lib_1.0.classes.column.hidden"]
      );
    } catch (e) {}

    this.setState({ defaultHiddenColumnNames });
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
    const { isAdmin } = this.props;
    const ids = rows.map(row => row.id);
    ids.sort();
    if (key === KEYS.META) {
      this.isMetaDown = false;
    } else if ((keyCode === KEYS.TILDA) && this.state.selection.length === 1) {
      const row = this.state.rows.find(row => row.id === this.state.selection[0]);
      if (!isAdmin) {
        try {
          fscreen.requestFullscreen(document.documentElement);
        } catch (e) {
          
        }
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
    const { selection: selected } = this.state;
    const { isMetaDown } = this;
    let viewItem;
    let mode = MODE.READ;
    if (!this.props.isAdmin) {
      if (!selection.length) {
        selection = selected;
      }
      for (let i = 0; i < selection.length; i++) {
        if (selected.indexOf(selection[i]) === -1) {
          selection = [selection[i]];
          break;
        }
      }
      try {
        fscreen.requestFullscreen(document.documentElement);
      } catch (e) {

      }
      mode = MODE.VIEW;
    } else if (!isMetaDown) {
      for (let i = 0; i < selection.length; i++) {
        if (selected.indexOf(selection[i]) === -1) {
          selection = [selection[i]];
          break;
        }
      }
    }
    viewItem = this.state.rows.find(row => row.id === selection[0]);
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
      setColumnWidths(nextColumnWidths);
      const data = JSON.stringify(defaultColumnWidths);
      localStorage['phoenix_lib_1.0.classes.column.width'] = data;
    } catch (e) {
      // ?
    }   
  };

  onHiddenColumnNamesChange = hiddenColumnNames => {
    try {
      const data = JSON.stringify(hiddenColumnNames);
      localStorage['phoenix_lib_1.0.classes.column.hidden'] = data;
    } catch (e) {
      // ?
    }   
  };

  onViewClick = () => {
    this.setState({ mode: MODE.VIEW });
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
              <Button variant="fab" disabled={selection.length === 0} aria-label="view" className={classes.button} onClick={this.onViewClick}>
                <ViewIcon />
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
      integratedFilteringColumnExtensions,
      defaultHiddenColumnNames,
      defaultColumnWidths,
      mode,
      htmlColumns,
      durationColumns,
      statusColumns,
      genreColumns,
      tooltipColumns,
      nameColumns,
      selection,
      program,
      editItem,
      viewItem,
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
          <NameTypeProvider for={nameColumns} />
          <TooltipTypeProvider for={tooltipColumns} />
          <HTMLTypeProvider for={htmlColumns} />
          <DurationTypeProvider for={durationColumns} />
          <StatusTypeProvider for={statusColumns} />
          <GenreTypeProvider for={genreColumns} />
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
          <IntegratedFiltering columnExtensions={integratedFilteringColumnExtensions} />
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
}))(ClassesGrid);