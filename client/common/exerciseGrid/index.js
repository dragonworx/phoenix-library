import * as React from 'react';
import PropTypes from 'prop-types';
import Paper from 'material-ui/Paper';
import {
  SortingState, SelectionState, FilteringState, SearchState,
  IntegratedFiltering, IntegratedSorting, IntegratedSelection,
  DataTypeProvider
} from '@devexpress/dx-react-grid';
import {
  Grid,
  VirtualTable, TableHeaderRow, TableFilterRow, TableSelection,
  DragDropProvider, TableColumnReordering, Toolbar, SearchPanel,
} from '@devexpress/dx-react-grid-material-ui';
import Button from 'material-ui/Button';
import AddIcon from 'material-ui-icons/Add';
import EditIcon from 'material-ui-icons/Edit';
import DeleteIcon from 'material-ui-icons/Delete';
import { LinearProgress } from 'material-ui/Progress';
import { withStyles } from 'material-ui/styles';
import axios from 'axios';
import styles from './styles';
import AddEdit from './addEdit';
import Alert from '../../common/alert';

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

const DescriptionFormatter = ({ value }) => {
  htmlNode.innerHTML = value;
  return <span>{htmlNode.textContent}</span>;
};

const DescriptionTypeProvider = props => (
  <DataTypeProvider
    formatterComponent={DescriptionFormatter}
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
    htmlColumns: ['description'],
    selection: [],
    editItem: null,
  };

  componentWillMount () {
    axios.get('/exercise/get')
      .then(res => {
        this.setState({
          mode: MODE.READ,
          rows: res.data
        });
      });
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

  onAdded = addedRow => {
    const rows = [
      ...this.state.rows,
    ];
    rows.push(addedRow);
    this.setState({ rows });
  };

  onSaved = savedRow => {
    const rows = [
      ...this.state.rows,
    ];
    const id = this.state.editItem.id;
    const row = rows.find(row => row.id === id);
    row.name = savedRow.name;
    row.springs = savedRow.springs;
    row.description = savedRow.description;
    row.video = savedRow.video;
    row.id = id;
    this.setState({ rows, editItem: null });
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
      mode,
      htmlColumns,
      selection,
      editItem,
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
        { readOnly ? null : this.renderEditControls() }

        <Grid rows={rows} columns={columns} getRowId={getRowId}>
          <DescriptionTypeProvider
            for={htmlColumns}
          />
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

          <VirtualTable
            columnExtensions={tableColumnExtensions}
            cellComponent={Cell}
          />
          <TableHeaderRow showSortingControls />
          <TableColumnReordering defaultOrder={columns.map(column => column.name)} />
          <TableFilterRow />
          { readOnly ? null : <TableSelection showSelectAll /> }
          <Toolbar />
          <SearchPanel />
        </Grid>

        { mode === MODE.ADD || mode === MODE.EDIT ? <AddEdit mode={mode} editItem={editItem} onAdded={this.onAdded} onSaved={this.onSaved} onClose={this.onAddEditClose} /> : null }
        { mode === MODE.CONFIRM_DELETE ? 
          <Alert 
            title="Confirm Delete" 
            message={`Do you really want to delete these exercises?`}
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