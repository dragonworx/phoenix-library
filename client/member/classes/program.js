import React from 'react';
import ProgramGroup from './programGroup';
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
    this.props.onDeleteCategory();
  };

  handleHoverRef = el => {
    this.hover = el;
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
                  <ProgramGroup 
                    key={`category_${category.labelId}`}
                    genreId={genreId}
                    program={program}
                    category={category}
                    hasHover={hover === category.index}
                    onMoveUp={this.onMoveUp}
                    onMoveDown={this.onMoveDown}
                    onDeleteCategory={this.onDeleteCategory}
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
    overflow: 'auto',
    border: '1px solid #ccc',
    borderRadius: 5,
    paddingTop: theme.spacing.unit * 2,
    paddingBottom: theme.spacing.unit * 2,
    backgroundColor: '#f8f8f8',
  }),
}))(ClassProgram);