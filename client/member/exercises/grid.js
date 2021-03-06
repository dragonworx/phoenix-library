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
import AddEdit from './addEdit';
import ViewExercise from './view';
import Alert from '../../common/alert';
import Thumbnail from '../../common/thumbnail';
import ThumbnailLink from '../../common/thumbnailLink';
import { distinct, trimUsage } from '../../common/util';
import { permissions } from '../session';

let ThumbnailRef = ThumbnailLink;

const Cell = (props) => {
  return <VirtualTable.Cell {...props} />;
};

const getRowId = row => row.id;

const MODE = {
  LOADING: 'loading',
  READ: 'read',
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

const htmlNode = document.createElement('div');

const calcGridHeight = showHeader => window.innerHeight - (showHeader ? 170 : 120);

const NameFormatter = ({ row }) => {
  return <Tooltip title={row.name}><label><span style={{ fontSize: '80%', color: '#ccc', marginRight: 2 }}>#{row.id}.</span><span className={NameFormatter.defaultProps.name}>{row.name}</span></label></Tooltip>;
};

const NameTypeProvider = props => {
  NameFormatter.defaultProps = props.classes;
  return <DataTypeProvider
    formatterComponent={NameFormatter}
    {...props}
  />;
};

const ThumbnailFormatter = ({ row }) => {
  return <ThumbnailRef row={row} />;
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

export const textToSprings = (value, height = 24, color = '#a1a1a1') => {
  const regex = /([1-9]) (red|blue|yellow)/gi;
  let results;
  let sub = value;
  while ((results = regex.exec(value)) !== null) {
    const count = parseInt(results[1], 10);
    const color = results[2];
    const imgs = `#${color}`.repeat(count);
    sub = sub.replace(results[0], imgs);
  }
  sub = sub
    .replace(/#(red|blue|yellow)/gi, `<img style="height:${height}px" src="/img/spring-$1.png" />`)
    .toLowerCase()
    .replace(/mat/gi, `<img style="height:${height}px" src="/img/mat.png" />`);
  return <Tooltip title={`Springs: ${value}`} placement="top"><span style={{ fontFamily: 'monospace', color }} dangerouslySetInnerHTML={{ __html: sub }}></span></Tooltip>;
};

const SpringFormatter = ({ value }) => {
  if (value) {
    return textToSprings(value);
  }
  return null;
};

const SpringTypeProvider = props => (
  <DataTypeProvider
    formatterComponent={SpringFormatter}
    {...props}
  />
);

const DateFormatter = ({ value }) => {
  return <span>{new Date(Date.parse(value)).toLocaleString()}</span>;
};

const DateTypeProvider = props => (
  <DataTypeProvider
    formatterComponent={DateFormatter}
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
  { columnName: 'revision', width: 50 },
  { columnName: 'createdAt', width: 100 },
  { columnName: 'updatedAt', width: 100 },
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

let defaultHiddenColumnNames = ['video'];

try {
  defaultColumnWidths = JSON.parse(
    localStorage["phoenix_lib_1.0.exercise.column.width"]
  );
} catch (e) {}

try {
  defaultHiddenColumnNames = JSON.parse(
    localStorage["phoenix_lib_1.0.exercise.column.hidden"]
  );
} catch (e) {}

class ExerciseGrid extends React.Component {
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
      { name: 'createdAt', title: 'Created' },
      { name: 'updatedAt', title: 'Modified' },
      { name: 'revision', title: 'Rev.' },
    ],
    rows: [],
    filteringStateColumnExtensions: [
      { columnName: 'photo', filteringEnabled: false },
    ],
    defaultHiddenColumnNames,
    defaultColumnWidths,
    nameColumns: ['name'],
    photoColumns: ['photo'],
    htmlColumns: ['description'],
    springColumns: ['springs'],
    labelColumns: ['name', 'genre', 'movement'],
    dateColumns: ['createdAt', 'updatedAt'],
    selection: [],
    editItem: null,
    viewItem: null,
    gridHeight: calcGridHeight(true),
  };

  constructor (props) {
    super(props);
    if (!props.isAdmin) {
      ThumbnailRef = Thumbnail;
    }
  }

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
          selection: [],
        });
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
    const { keyCode, altKey, key } = e;
    const { selection, rows } = this.state;
    const ids = rows.map(row => row.id);
    ids.sort();
    if (key === KEYS.META) {
      this.isMetaDown = false;
    } else if (keyCode === KEYS.TILDA && this.state.selection.length === 1) {
      const row = this.state.rows.find(row => row.id === this.state.selection[0]);
      if (altKey) {
        this.setState({ mode: MODE.EDIT, editItem: row });
      } else {
        this.setState({ mode: MODE.VIEW, viewItem: row });
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
    this.setState({ gridHeight: calcGridHeight(this.props.showHeader) });
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

  onViewClose = () => {
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

  onAdded = (addedRow, usage) => {
    this.updateRowLabels(addedRow, usage);
    const rows = [
      ...this.state.rows,
    ];
    addedRow.createdAt = new Date().toISOString();
    addedRow.updatedAt = addedRow.createdAt;
    addedRow.usage = usage;
    addedRow.revision = 1;
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
    row.revision = savedRow.revision;
    row.updatedAt = new Date().toISOString();
    this.updateRowLabels(row, usage);
    this.setState({ rows, editItem: null, selection: [] });
  };

  onColumnWidthsChange = nextColumnWidths => {
    try {
      setColumnWidths(nextColumnWidths);
      const data = JSON.stringify(defaultColumnWidths);
      localStorage['phoenix_lib_1.0.exercise.column.width'] = data;
    } catch (e) {
      // ?
    }   
  };

  onHiddenColumnNamesChange = hiddenColumnNames => {
    try {
      const data = JSON.stringify(hiddenColumnNames);
      localStorage['phoenix_lib_1.0.exercise.column.hidden'] = data;
    } catch (e) {
      // ?
    }   
  };

  onViewClick = () => {
    this.setState({ mode: MODE.VIEW });
  };

  renderEditControls () {
    const { selection } = this.state;
    const { classes, isAdmin } = this.props;

    return (
      <span className={classes.root}>
      {
        isAdmin
          ? (
            <span>
              <Button variant="fab" color="primary" aria-label="add" className={classes.button} onClick={this.onAddClick}>
                <AddIcon />
              </Button>
              <Button variant="fab" aria-label="edit" disabled={selection.length !== 1} className={classes.button} onClick={this.onEditClick}>
                <EditIcon />
              </Button>
              {
                permissions.canDeleteExercise
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
      defaultHiddenColumnNames,
      defaultColumnWidths,
      mode,
      htmlColumns,
      springColumns,
      labelColumns,
      nameColumns,
      dateColumns,
      photoColumns,
      selection,
      editItem,
      viewItem,
    } = this.state;

    
    const { isAdmin, classes, showHeader } = this.props;
    const gridHeight = calcGridHeight(showHeader);

    const labels = this.labels;

    if (mode === MODE.LOADING) {
      return (
        <Paper>
          <LinearProgress classes={{ colorPrimary: classes.progressFG, barColorPrimary: classes.progressBG }} />
        </Paper>
      );
    };

    return (
      <Paper id="grid">
        { isAdmin && this.renderEditControls() }
        <Grid rows={rows} columns={columns} getRowId={getRowId}>
          <DescriptionTypeProvider for={htmlColumns} />
          <DateTypeProvider for={dateColumns} />
          <TooltipTypeProvider for={labelColumns} />
          <SpringTypeProvider for={springColumns} />
          <NameTypeProvider for={nameColumns} classes={classes} />
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
          <VirtualTable columnExtensions={tableColumnExtensions} cellComponent={Cell} height={gridHeight} />
          <TableColumnResizing defaultColumnWidths={defaultColumnWidths} onColumnWidthsChange={this.onColumnWidthsChange} />
          <TableHeaderRow showSortingControls />
          {
            showHeader ? [
              <TableColumnReordering defaultOrder={columns.map(column => column.name)} key="g0" />,
              <TableFilterRow key="g1" />,
            ]
          : null
          }
          <TableSelection showSelectAll={isAdmin} highlightRow selectByRowClick showSelectionColumn={isAdmin} />
          <TableColumnVisibility defaultHiddenColumnNames={defaultHiddenColumnNames} onHiddenColumnNamesChange={this.onHiddenColumnNamesChange}/>  
          {
            showHeader ? [
              <Toolbar key="g2" />,
              <ColumnChooser key="g3" />,
              <SearchPanel key="g4" />,
            ]
            : null
          }
        </Grid>
        {
          mode === MODE.ADD || mode === MODE.EDIT ? 
          <AddEdit name={MODE.EDIT && editItem ? editItem.name : 'New Exercise'} mode={mode} labels={labels} editItem={mode === MODE.EDIT && editItem} onAdded={this.onAdded} onSaved={this.onSaved} onClose={this.onAddEditClose} /> : null
        }
        {
          mode === MODE.VIEW ? <ViewExercise viewItem={viewItem} onClose={this.onViewClose} /> : null
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
  name: {
		color: '#254779',
		fontWeight: 'bold',
		fontSize: '110%',
  },
  progressFG: {
    backgroundColor: '#2aff48',
  },
  progressBG: {
    backgroundColor: '#fff',
  },
}))(ExerciseGrid);