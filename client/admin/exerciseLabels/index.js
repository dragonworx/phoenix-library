import React from 'react';
import { withStyles } from 'material-ui/styles';
import List from 'material-ui/List';
import { FormLabel } from 'material-ui/Form';
import LabelGroup from './labelGroup';
import styles from './styles';

const LABEL = {
  GENRE: 0,
  MOVEMENT_CATEGORY: 1
};

class ExerciseLabels extends React.Component {
  state = {
    open: true
  };

  constructor (props) {
    super(props);
    this.genres = this.props.labels.filter(label => label.type === LABEL.GENRE);
    this.movementCategories = this.props.labels.filter(label => label.type === LABEL.MOVEMENT_CATEGORY);
    const keys = this.movementCategories.map(label => label.name);
    const options = {};
    for (let key of keys) {
      options[key] = false;
    }
    this.options = options;
  }

  handleClick = () => {
    this.setState({ open: !this.state.open });
  };

  handleGroupChange = (title, options) => {
    this.props.onChange(title, options);
  };

  render() {
    const { classes } = this.props;
    const { genres, options } = this;

    return (
      <div className={classes.root}>
        <FormLabel className={classes.descLabel} component="legend">Usage</FormLabel>
        <div className={classes.container}>
          <List component="nav">
          {
            genres.map(label => <LabelGroup key={`group_${label.name}`} title={label.name} options={options} onChange={this.handleGroupChange} />)
          }
          </List>
        </div>
      </div>
    );
  }
}

export default withStyles(styles)(ExerciseLabels);