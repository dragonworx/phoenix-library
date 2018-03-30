import React from 'react';
import axios from 'axios';
import {
  DataTypeProvider,
} from '@devexpress/dx-react-grid';
import Tooltip from 'material-ui/Tooltip';
import ThumbnailLink from '../../common/thumbnailLink';
import DataGrid, { MODE } from '../../common/dataGrid/';
import AddEdit from './addEdit';
import { distinct, trimUsage } from '../../common/util';

const dataTypeProvider = (Formatter, forColumns) => props => {(
  <DataTypeProvider
      formatterComponent={Formatter}
      for={forColumns}
      {...props}
    />
  );};

const getRowId = row => row.id;
const htmlNode = document.createElement('div');
const dataProviders = [];

const nameColumns = ['name'];
const photoColumns = ['photo'];
const htmlColumns = ['description'];
const labelColumns = ['name', 'genre', 'movement', 'springs'];

(function initDataProviders () {
  dataProviders.push(dataTypeProvider(({ row }) => {
    // Name
    return <label><span style={{ fontSize: '80%', color: '#ccc', marginRight: 2 }}>#{row.id}.</span>{row.name}</label>;
  }), nameColumns);

  dataProviders.push(dataTypeProvider(({ row }) => {
    // Thumbnail
    return <ThumbnailLink row={row} />;
  }), photoColumns);

  dataProviders.push(dataTypeProvider(({ value }) => {
    // Description
    htmlNode.innerHTML = value;
    return <Tooltip title={htmlNode.textContent} placement="top"><span>{htmlNode.textContent}</span></Tooltip>;
  }), htmlColumns);

  dataProviders.push(dataTypeProvider(({ value }) => {
    // Tooltip
    if (value) {
      const values = Array.isArray(value) ? value.join(', ') : String(value);
      return <Tooltip title={values} placement="top"><span>{values}</span></Tooltip>;
    }
    return null;
  }), labelColumns);
})();

const columns = [
  { name: 'photo', title: 'Photo' },
  { name: 'name', title: 'Name' },
  { name: 'genre', title: 'Genre' },
  { name: 'movement', title: 'Movement Cat.' },
  { name: 'springs', title: 'Springs' },
  { name: 'description', title: 'Description' },
  { name: 'video', title: 'Video URL' },
];

const filteringStateColumnExtensions = [
  { columnName: 'photo', filteringEnabled: false },
];

// const defaultColumnWidths = [
//   { columnName: 'photo', width: 50 },
//   { columnName: 'name', width: 50 },
//   { columnName: 'genre', width: 100 },
//   { columnName: 'movement', width: 100 },
//   { columnName: 'springs', width: 50 },
//   { columnName: 'description', width: 100 },
//   { columnName: 'video', width: 50 },
// ];

const defaultHiddenColumnNames = ['video'];

export default class Exercises extends React.Component {
  state = {
    mode: MODE.LOADING,
    rows: [],
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
    row.photo = savedRow.photo || row.photo;
    row.id = id;
    row.usage = usage;
    this.updateRowLabels(row, usage);
    this.setState({ rows, editItem: null, selection: [] });
  };

  onAddEditClose = () => {
    this.setState({ mode: MODE.READ });
  };

  addEdit = () => (
    <AddEdit 
      mode={this.state.mode} labels={this.labels} editItem={this.state.mode === MODE.EDIT && this.state.editItem} onAdded={this.onAdded} onSaved={this.onSaved} onClose={this.onAddEditClose}
    />
  );

  render () {
    const { rows, mode, editItem, selection } = this.state;

    return <DataGrid
      readOnly={false}
      addEdit={this.addEdit}
      getRowId={getRowId}
      rows={rows}
      selection={selection}
      mode={mode}
      editEdit={editItem}
      dataProviders={dataProviders}
      defaultHiddenColumnNames={defaultHiddenColumnNames}
      filteringStateColumnExtensions={filteringStateColumnExtensions}
      columns={columns}
    />;
  }
};