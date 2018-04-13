import React from 'react';
import ClassMovementCategory from './classMovementCategory';
import { withStyles } from 'material-ui/styles';
import HoverGroup from '../../common/hover';

class ClassProgram extends React.Component {
  onMoveUp = category => {
    const { program } = this.props;
    const index = program.indexOf(category);
    program.splice(index, 1);
    program.splice(index - 1, 0, category);
    program.forEach((category, i) => category.index = i);
    this.hover.setState({ hover: category.index });
    this.setState({ program });
  };

  onMoveDown = category => {
    const { program } = this.props;
    const index = program.indexOf(category);
    program.splice(index, 1);
    program.splice(index + 1, 0, category);
    program.forEach((category, i) => category.index = i);
    this.hover.setState({ hover: category.index });
    this.setState({ program });
  };

  onDeleteCategory = () => {
    const { program } = this.props;
    this.props.onDeleteCategory();
    program.forEach((category, i) => category.index = i);
  };

  handleHoverRef = el => {
    this.hover = el;
  };

  onDurationChange = exercise => {
    this.props.onDurationChange(exercise);
  };

  render () {
    const { classes, program, genreId } = this.props;

    return (
      <div className={classes.container}>
        <HoverGroup ref={this.handleHoverRef} className={classes.root} render={
          hover => (
            <div>
              {
                program.map(category => (
                  <ClassMovementCategory 
                    key={`category_${category.index}-${category.labelId}`}
                    genreId={genreId}
                    program={program}
                    category={category}
                    hasHover={hover === category.index}
                    onMoveUp={this.onMoveUp}
                    onMoveDown={this.onMoveDown}
                    onDeleteCategory={this.onDeleteCategory}
                    onDurationChange={this.onDurationChange}
                  />
                ))
              }
            </div>
          )
        } />
      </div>
    );
  }
};

export default withStyles(theme => ({
  container: {
    position: 'relative',
  },
  root: theme.mixins.gutters({
    height: 400,
    overflowY: 'scroll',
    border: '1px solid #ccc',
    borderRadius: 5,
    paddingTop: theme.spacing.unit * 2,
    paddingBottom: theme.spacing.unit * 2,
    backgroundColor: '#fffbf3',
  }),
}))(ClassProgram);