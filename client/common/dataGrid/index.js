import * as React from 'react';
import PropTypes from 'prop-types';
import Paper from 'material-ui/Paper';
import {
  SortingState, SelectionState, FilteringState, SearchState,
  IntegratedFiltering, IntegratedSorting, IntegratedSelection,
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
import { LinearProgress } from 'material-ui/Progress';
import { withStyles } from 'material-ui/styles';
import axios from 'axios';
import Alert from '../../common/alert';

const Cell = (props) => {
  return <VirtualTable.Cell {...props} />;
};

export const MODE = {
  LOADING: 'loading',
  READ: 'read',
  ADD: 'add',
  EDIT: 'edit',
  CONFIRM_DELETE: 'confirm_delete',
};

class DataGrid extends React.Component {
  state = {
    mode: MODE.LOADING,
    rows: [],
    selection: [],
    editItem: null,
  };

  constructor (props) {
    super(props);
    this.state.mode = props.mode || this.state.mode;
    this.state.rows = props.rows || this.state.rows;
    this.state.selection = props.selection || this.state.selection;
    this.state.editItem = props.editItem || this.state.editItem;
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
    this.setState({ selection });
  };

  renderEditControls () {
    const { selection, rows } = this.state;
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
        <span className={classes.count}>{`You have ${rows.length} Exercise${rows.length === 1 ? '' : 's'} saved.`}</span>
      </div>
    );
  }

  render () {
    const { 
      rows,
      tableColumnExtensions,
      // defaultColumnWidths,
      mode,
      selection,
    } = this.state;

    const {
      readOnly,
      addEdit,
      getRowId,
      dataProviders,
      defaultHiddenColumnNames,
      filteringStateColumnExtensions,
      columns,
    } = this.props;

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
          { dataProviders }
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
          addEdit() : null
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

DataGrid.propTypes = {
  classes: PropTypes.object.isRequired,
};

export default withStyles(theme => ({
  root: {
    position: 'absolute',
    zIndex: 1100,
  },
  button: {
    margin: theme.spacing.unit,
  },
  count: {
    display: 'inline-block',
    marginLeft: 10,
    color: '#ccc',
  }
}))(DataGrid);