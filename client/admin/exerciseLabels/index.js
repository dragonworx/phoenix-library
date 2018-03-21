import React from 'react';
import { withStyles } from 'material-ui/styles';
import List from 'material-ui/List';
import { FormLabel } from 'material-ui/Form';
import LabelGroup from './labelGroup';
import styles from './styles';

const LABEL = {
  ROOT: 0,
  SUB: 1
};

class ExerciseLabels extends React.Component {
  state = {
    open: true
  };

  constructor (props) {
    super(props);
    this.rootLabels = this.props.labels.filter(label => label.type === LABEL.ROOT);
    this.subLabels = this.props.labels.filter(label => label.type === LABEL.SUB);
    this.subLabels.forEach(label => label.selected = false/*TODO: reflect edit state*/);
  }

  handleClick = () => {
    this.setState({ open: !this.state.open });
  };

  handleGroupChange = (rootLabel, selections) => {
    this.props.onChange(rootLabel, selections);
  };

  render() {
    const { classes, usage } = this.props;
    const { rootLabels, subLabels } = this;

    return (
      <div className={classes.root}>
        <FormLabel className={classes.descLabel} component="legend">Usage</FormLabel>
        <div className={classes.container}>
          <List component="nav">
          {
            rootLabels.map(rootLabel => <LabelGroup key={`group_${rootLabel.name}`} usage={usage[rootLabel.id]} rootLabel={rootLabel} subLabels={subLabels} onChange={this.handleGroupChange} />)
          }
          </List>
        </div>
      </div>
    );
  }
}

export default withStyles(styles)(ExerciseLabels);