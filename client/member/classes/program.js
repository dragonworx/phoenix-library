import React from 'react';
import ProgramGroup from './programGroup';
import { withStyles } from 'material-ui/styles';
import axios from 'axios';

class ClassProgram extends React.Component {
  onMoveUpClick = () => {

  };

  onMoveDownClick = () => {

  };

  onAddClick = async movementId => {
    debugger
    const { genreId } = this.props;
    const result = await axios.get(`/class/category/exercises/${genreId}/${movementId}`);
    debugger;
  };

  onRemoveClick = () => {

  };

  render () {
    const { classes, program } = this.props;

    return (
      <div className={classes.root}>
        {
          program.map(category => <ProgramGroup 
            key={`category_${category.labelId}`} 
            category={category} 
            onMoveUpClick={this.onMoveUpClick} 
            onMoveDownClick={this.onMoveDownClick}
            onAddClick={movementId => this.onAddClick(movementId)}
            onRemoveClick={this.onRemoveClick}
          />)
        }
      </div>
    );
  }
};

export default withStyles(theme => ({
  root: theme.mixins.gutters({
    height: 400,
    overflow: 'auto',
    border: '1px solid #ccc',
    borderRadius: 5,
    paddingBottom: theme.spacing.unit * 3,
  }),
}))(ClassProgram);