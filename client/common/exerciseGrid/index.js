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
} from '@devexpress/dx-react-grid-material-ui';
import Button from 'material-ui/Button';
import Icon from 'material-ui/Icon';
import AddIcon from 'material-ui-icons/Add';
import EditIcon from 'material-ui-icons/Edit';
import DeleteIcon from 'material-ui-icons/Delete';
import { withStyles } from 'material-ui/styles';
import styles from './styles';
import AddEdit from './addEdit';

const Cell = (props) => {
  return <VirtualTable.Cell {...props} />;
};

const getRowId = row => row.id;

const MODE = {
  READ: 0,
  ADD: 1,
  EDIT: 2,
  CONFIRM_DELETE: 3
};

class ExerciseGrid extends React.PureComponent {
  state = {
    mode: MODE.READ,
    columns: [
      { name: 'thumbnail', title: 'Photo' },
      { name: 'name', title: 'Name' },
      { name: 'genre', title: 'Genre' },
      { name: 'movement', title: 'Movement Cat.' },
      { name: 'springs', title: 'Springs' },
      { name: 'description', title: 'Description' },
      { name: 'video_url', title: 'Video URL' },
    ],
    rows: [
           
    ],
    filteringStateColumnExtensions: [
      { columnName: 'thumbnail', filteringEnabled: false },
    ],
  };

  onAddClick = () => {
    this.setState({ mode: MODE.ADD });
  };

  onEditClick = () => {
    
  };

  onDeleteClick = () => {
    
  };

  onAddEditClose = () => {
    this.setState({ mode: MODE.READ });
  };

  renderEditControls () {
    const { classes } = this.props;

    return (
      <div>
        <Button variant="fab" color="primary" aria-label="add" className={classes.button} onClick={this.onAddClick}>
          <AddIcon />
        </Button>
        <Button variant="fab" aria-label="edit" className={classes.button} onClick={this.onEditClick}>
          <EditIcon />
        </Button>
        <Button variant="fab" color="secondary" disabled={false} aria-label="delete" className={classes.button} onClick={this.onDeleteClick}>
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
    } = this.state;
    const { classes, readOnly } = this.props;

    return (
      <Paper>
        { readOnly ? null : this.renderEditControls() }

        <Grid rows={rows} columns={columns} getRowId={getRowId}>
          <DragDropProvider />

          <FilteringState columnExtensions={filteringStateColumnExtensions} />
          <SearchState />
          <SortingState
            defaultSorting={[
              { columnName: 'name', direction: 'asc' },
              { columnName: 'springs', direction: 'asc' },
              { columnName: 'genre', direction: 'asc' },
              { columnName: 'movement', direction: 'asc' },
            ]}
          />
          { readOnly ? null : <SelectionState /> }

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

        { mode === MODE.ADD ? <AddEdit mode="add" onClose={this.onAddEditClose} /> : null }
      </Paper>
    );
  }
}

ExerciseGrid.propTypes = {
  classes: PropTypes.object.isRequired,
};

export default withStyles(styles)(ExerciseGrid);