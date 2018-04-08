import React from 'react';
import ProgramGroup from './programGroup';
import { withStyles } from 'material-ui/styles';
import HoverGroup from '../../common/hover';

class ClassProgram extends React.Component {
  render () {
    const { classes, program, genreId } = this.props;

    return (
      <HoverGroup className={classes.root} render={
        hover => program.map(category => (
            <ProgramGroup 
              key={`category_${category.labelId}`}
              genreId={genreId}
              category={category}
              hasHover={hover === category.index}
            />
          ))
      } />
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
    backgroundColor: 'fcfcfc',
  }),
}))(ClassProgram);