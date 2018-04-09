import React from 'react';
import ProgramGroup from './programGroup';
import { withStyles } from 'material-ui/styles';
import Button from "material-ui/Button";
import IconButton from "material-ui/IconButton";
import AddIcon from "material-ui-icons/AddCircle";
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

  handleHoverRef = el => {
    this.hover = el;
  };

  handleAddCatClick = () => {

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
                  />
                ))
              }
            </div>
          )
        } />
        <IconButton variant="fab" color="primary" aria-label="add movement category" className={classes.addCat} onClick={this.handleAddCatClick}>
          <AddIcon />
        </IconButton>
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
  addCat: {
    position: 'absolute',
    top: -40,
    left: 61,
  },
}))(ClassProgram);