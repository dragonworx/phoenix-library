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
import AddEdit from './addEdit';
import Alert from '../../common/alert';
import ThumbnailLink from '../../common/thumbnailLink';
import { distinct, trimUsage } from '../../common/util';

const Cell = (props) => {
  return <VirtualTable.Cell {...props} />;
};

const getRowId = row => row.id;

const MODE = {
  LOADING: 'loading',
  READ: 'read',
  ADD: 'add',
  EDIT: 'edit',
  CONFIRM_DELETE: 'confirm_delete',
};

const KEYS = {
  OPTION: 18,
  ENTER: 13,
  SPACE: 32,
  UP: 38,
  DOWN: 40,
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

const ThumbnailFormatter = ({ row }) => {
  return <ThumbnailLink row={row} />;
};

const ThumbnailTypeProvider = props => (
  <DataTypeProvider
    formatterComponent={ThumbnailFormatter}
    {...props}
  />
);

const DescriptionFormatter = ({ value }) => {
  htmlNode.innerHTML = value;
  return <Tooltip title={htmlNode.textContent} placement="top"><span>{htmlNode.textContent}</span></Tooltip>;
};

const DescriptionTypeProvider = props => (
  <DataTypeProvider
    formatterComponent={DescriptionFormatter}
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

const SpringFormatter = ({ value }) => {
  if (value) {
    const regex = /([1-9]) (red|blue|yellow)/gi;
    let results;
    let sub = value;
    while ((results = regex.exec(value)) !== null) {
      const count = parseInt(results[1], 10);
      const color = results[2];
      const imgs = `#${color}`.repeat(count);
      sub = sub.replace(results[0], imgs);
    }
    sub = sub.replace(/#(red|blue|yellow)/gi, '<img style="height:32px" src="/img/spring-$1.png" />').toLowerCase();
    return <Tooltip title={value} placement="top"><span dangerouslySetInnerHTML={{ __html: sub }}></span></Tooltip>;
  }
  return null;
};

const SpringTypeProvider = props => (
  <DataTypeProvider
    formatterComponent={SpringFormatter}
    {...props}
  />
);

let defaultColumnWidths = [
  { columnName: 'photo', width: 100 },
  { columnName: 'name', width: 300 },
  { columnName: 'genre', width: 200 },
  { columnName: 'movement', width: 200 },
  { columnName: 'springs', width: 200 },
  { columnName: 'description', width: 600 },
  { columnName: 'video', width: 150 },
];

try {
  defaultColumnWidths = JSON.parse(localStorage['phoenix_lib_1.columns']);
} catch (e) {
  console.warn('Could not load column widths: ' + String(e));
}

class ExerciseGrid extends React.PureComponent {
  state = {
    mode: MODE.LOADING,
    columns: [
      { name: 'photo', title: 'Photo' },
      { name: 'name', title: 'Name' },
      { name: 'genre', title: 'Genre' },
      { name: 'movement', title: 'Movement Cat.' },
      { name: 'springs', title: 'Springs' },
      { name: 'description', title: 'Description' },
      { name: 'video', title: 'Video URL' },
    ],
    rows: [],
    filteringStateColumnExtensions: [
      { columnName: 'photo', filteringEnabled: false },
    ],
    defaultHiddenColumnNames: ['video'],
    defaultColumnWidths,
    nameColumns: ['name'],
    photoColumns: ['photo'],
    htmlColumns: ['description'],
    springColumns: ['springs'],
    labelColumns: ['name', 'genre', 'movement'],
    selection: [],
    editItem: null,
  };

  componentWillMount () {
    axios.get('/exercise/get')
      .then(res => {
        const { exercises, labels } = res.data;
        this.labels = labels;
        exercises.forEach(exercise => {
          this.updateRowLabels(exercise, exercise.usage);
        });
        this.setState({
          mode: MODE.READ,
          rows: exercises,
          selection: [exercises[exercises.length - 1].id],
        });
        this.props.onLoad(res.data);
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
    const ids = rows.map(row => row.id);
    ids.sort();
    if (keyCode === KEYS.OPTION) {
      this.isCommandDown = false;
    } else if ((keyCode === KEYS.ENTER || keyCode === KEYS.SPACE) && this.state.selection.length === 1) {
      const row = this.state.rows.find(row => row.id === this.state.selection[0]);
      this.setState({ mode: MODE.EDIT, editItem: row });
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

  updateRowLabels (row, usage) {
    trimUsage(usage);
    const labels = {};
    this.labels.forEach(label => labels[label.id] = label);
    const genres = Object.entries(usage)
      .map(({ 0: id }) => labels[id].name);
    const movementCategories = [];
    Object.entries(usage)
      .map(({ 1: selections }) => Object.keys(selections))
      .forEach(ids => ids.forEach(id => movementCategories.push(labels[id].name)));
    genres.sort();
    movementCategories.sort();
    row.genre = genres;
    row.movement = distinct(movementCategories);
  }

  onAddClick = () => {
    this.setState({ mode: MODE.ADD });
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

  onConfirmDeleteClose = async didAccept => {
    if (didAccept) {
      const ids = this.state.selection;
      await axios.post('/exercise/delete', { ids: ids });
      const rows = this.state.rows.filter(row => ids.indexOf(row.id) === -1);
      this.setState({ rows, selection: [] });
    }
    this.setState({ mode: MODE.READ });
  };

  onSelectionChange = selection => {
    const { selection: selected } = this.state;
    const { isCommandDown } = this;
    if (this.props.readOnly) {
      if (!selection.length) {
        return this.setState({ selection: selected });
      }
      for (let i = 0; i < selection.length; i++) {
        if (selected.indexOf(selection[i]) === -1) {
          selection = [selection[i]];
          break;
        }
      }
    } else if (!isCommandDown) {
      for (let i = 0; i < selection.length; i++) {
        if (selected.indexOf(selection[i]) === -1) {
          selection = [selection[i]];
          break;
        }
      }
    }
    this.setState({ selection });
  };

  onAdded = (addedRow, usage) => {
    this.updateRowLabels(addedRow, usage);
    const rows = [
      ...this.state.rows,
    ];
    addedRow.usage = usage;
    rows.push(addedRow);
    this.setState({ rows, selection: [addedRow.id] });
  };

  onSaved = (savedRow, usage) => {
    const rows = [
      ...this.state.rows,
    ];
    const id = this.state.editItem.id;
    const row = rows.find(row => row.id === id);
    row.name = savedRow.name;
    row.springs = savedRow.springs;
    row.description = savedRow.description;
    row.video = savedRow.video;
    row.photo = savedRow.photo || row.photo;
    row.id = id;
    row.usage = usage;
    this.updateRowLabels(row, usage);
    this.setState({ rows, editItem: null, selection: [] });
  };

  onColumnWidthsChange = nextColumnWidths => {
    try {
      const data = JSON.stringify(nextColumnWidths);
      localStorage['phoenix_lib_1.columns'] = data;
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
      springColumns,
      labelColumns,
      nameColumns,
      photoColumns,
      selection,
      editItem,
    } = this.state;
    const { readOnly } = this.props;
    const labels = this.labels;

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
          <DescriptionTypeProvider for={htmlColumns} />
          <TooltipTypeProvider for={labelColumns} />
          <SpringTypeProvider for={springColumns} />
          <NameTypeProvider for={nameColumns} />
          <ThumbnailTypeProvider for={photoColumns} />
          <DragDropProvider />
          <FilteringState columnExtensions={filteringStateColumnExtensions} />
          <SearchState />
          <SortingState
            defaultSorting={[
              { columnName: 'id', direction: 'desc' },
              { columnName: 'name', direction: 'asc' },
              { columnName: 'springs', direction: 'asc' },
              { columnName: 'genre', direction: 'asc' },
              { columnName: 'movement', direction: 'asc' },
            ]}
          />
          <SelectionState selection={selection} onSelectionChange={this.onSelectionChange} />
          <IntegratedFiltering />
          <IntegratedSorting />
          <IntegratedSelection />
          <VirtualTable columnExtensions={tableColumnExtensions} cellComponent={Cell} height={650} />
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
          mode === MODE.ADD || mode === MODE.EDIT ? 
          <AddEdit mode={mode} labels={labels} editItem={mode === MODE.EDIT && editItem} onAdded={this.onAdded} onSaved={this.onSaved} onClose={this.onAddEditClose} /> : null
        }
        {
          mode === MODE.CONFIRM_DELETE ? 
          <Alert 
            title="Confirm Delete" 
            message={`Do you really want to delete ${selection.length === 1 ? 'this exercise' : 'these ' + selection.length + ' exercises'}?`}
            submitText="Delete" 
            onClose={this.onConfirmDeleteClose} 
          /> : null
        }
      </Paper>
    );
  }
}

ExerciseGrid.propTypes = {
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
}))(ExerciseGrid);