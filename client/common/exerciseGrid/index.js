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
  ColumnChooser, TableColumnVisibility, /*TableColumnResizing,*/
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
import styles from './styles';

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

const htmlNode = document.createElement('div');

const ThumbnailFormatter = ({ row }) => {
  return row.photo
  ? <ThumbnailLink photo={row.photo} thumbnail={row.thumbnail} cacheBust={row.cacheBust} />
  : <img src="/img/image-placeholder.png" />;
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

class ExerciseGrid extends React.PureComponent {
  state = {
    mode: MODE.LOADING,
    columns: [
      { name: 'thumbnail', title: 'Photo' },
      { name: 'name', title: 'Name' },
      { name: 'genre', title: 'Genre' },
      { name: 'movement', title: 'Movement Cat.' },
      { name: 'springs', title: 'Springs' },
      { name: 'description', title: 'Description' },
      { name: 'video', title: 'Video URL' },
    ],
    rows: [],
    filteringStateColumnExtensions: [
      { columnName: 'thumbnail', filteringEnabled: false },
    ],
    defaultHiddenColumnNames: ['video'],
    defaultColumnWidths: [
      { columnName: 'thumbnail', width: 50 },
      { columnName: 'name', width: 50 },
      { columnName: 'genre', width: 100 },
      { columnName: 'movement', width: 100 },
      { columnName: 'springs', width: 50 },
      { columnName: 'description', width: 100 },
      { columnName: 'video', width: 50 },
    ],
    thumbnailColumns: ['thumbnail'],
    htmlColumns: ['description'],
    labelColumns: ['name', 'genre', 'movement', 'springs'],
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
          exercise.cacheBust = Date.now();
        });
        this.setState({
          mode: MODE.READ,
          rows: exercises,
        });
      });
  }

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

  onConfirmDeleteClose = didAccept => {
    if (didAccept) {
      const ids = this.state.selection;
      axios.post('/exercise/delete', {
        ids: ids
      }).then(() => {
        const rows = this.state.rows.filter(row => ids.indexOf(row.id) === -1);
        this.setState({ rows, selection: [] });
      });
    }
    this.setState({ mode: MODE.READ });
  };

  onSelectionChange = selection => {
    this.setState({selection});
  };

  onAdded = (addedRow, usage) => {
    this.updateRowLabels(addedRow, usage);
    const rows = [
      ...this.state.rows,
    ];
    addedRow.usage = usage;
    rows.push(addedRow);
    this.setState({ rows });
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
    row.photo = savedRow.photo;
    row.thumbnail = savedRow.thumbnail;
    row.id = id;
    row.cacheBust = Date.now();
    this.updateRowLabels(row, usage);
    this.setState({ rows, editItem: null, selection: [] });
  };

  renderEditControls () {
    const { selection } = this.state;
    const { classes } = this.props;

    return (
      <div className={classes.root}>
        <Button variant="fab" color="primary" aria-label="add" className={classes.button} onClick={this.onAddClick}>
          <AddIcon />
        </Button>
        <Button variant="fab" aria-label="edit" disabled={selection.length !== 1} className={classes.button} onClick={this.onEditClick}>
          <EditIcon />
        </Button>
        <Button variant="fab" color="secondary" disabled={selection.length === 0} aria-label="delete" className={classes.button} onClick={this.onDeleteClick}>
          <DeleteIcon />
        </Button>
      </div>
    );
  }

  render () {
    const { 
      rows,
      columns, 
      tableColumnExtensions, 
      filteringStateColumnExtensions,
      defaultHiddenColumnNames,
      // defaultColumnWidths,
      mode,
      htmlColumns,
      labelColumns,
      thumbnailColumns,
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
        { readOnly ? null : this.renderEditControls() }
        <Grid rows={rows} columns={columns} getRowId={getRowId}>
          <DescriptionTypeProvider for={htmlColumns} />
          <TooltipTypeProvider for={labelColumns} />
          <ThumbnailTypeProvider for={thumbnailColumns} />
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
          { readOnly ? null : <SelectionState selection={selection} onSelectionChange={this.onSelectionChange} /> }
          <IntegratedFiltering />
          <IntegratedSorting />
          { readOnly ? null : <IntegratedSelection /> }
          <VirtualTable columnExtensions={tableColumnExtensions} cellComponent={Cell}
          />
          {/*<TableColumnResizing defaultColumnWidths={defaultColumnWidths} />*/}
          <TableHeaderRow showSortingControls />
          <TableColumnReordering defaultOrder={columns.map(column => column.name)} />
          <TableFilterRow />
          { readOnly ? null : <TableSelection showSelectAll /> }
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

export default withStyles(styles)(ExerciseGrid);