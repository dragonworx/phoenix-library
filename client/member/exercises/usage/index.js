import React from 'react';
import { withStyles } from 'material-ui/styles';
import List from 'material-ui/List';
import { FormLabel } from 'material-ui/Form';
import LabelGroup from './labelGroup';

const LABEL = {
  ROOT: 0,
  SUB: 1
};

class ExerciseLabels extends React.PureComponent {
  state = {
    open: true
  };

  constructor (props) {
    super(props);
    this.rootLabels = this.props.labels.filter(label => label.type === LABEL.ROOT);
    this.subLabels = this.props.labels.filter(label => label.type === LABEL.SUB);
    this.subLabels.forEach(label => label.selected = null);
    this.subLabels.sort((a, b) => {
      if (a.name < b.name) {
        return -1;
      } else if (a.name > b.name) {
        return 1;
      } else {
        return 0;
      }
    });
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
            rootLabels.map(rootLabel => <LabelGroup key={`group_${rootLabel.name}`} usage={usage && usage[rootLabel.id]} rootLabel={rootLabel} subLabels={subLabels} onChange={this.handleGroupChange} />)
          }
          </List>
        </div>
      </div>
    );
  }
}

export default withStyles(theme => ({
  root: {

  },
  container: {
    width: '100%',
    maxWidth: 360,
    backgroundColor: '#eef9fe',
    maxHeight: 275,
    minHeight: 275,
    overflow: 'auto',
    border: '1px solid #e7e7e7',
    marginTop: 5,
    borderRadius: 5,
  },
  nested: {
    paddingLeft: theme.spacing.unit * 4,
  },
  red: {
    backgroundColor: 'red'
  }
}))(ExerciseLabels);