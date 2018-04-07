import React from 'react';
import ProgramGroup from './programGroup';
import { withStyles } from 'material-ui/styles';

class ClassProgram extends React.PureComponent {
  state = {
    hover: null,
  };

  onMouseMove = e => {
    const target = e.target;
    if (target.getAttribute('data-type') === 'program') {
      this.setState({ hover: null });
    } else {
      try {
        let obj = target;
        while (obj && obj.getAttribute('data-type') !== 'program') {
          if (obj.getAttribute('data-type') === 'program-group') {
            this.setState({ hover: parseInt(obj.getAttribute('data-index'), 10) });
          }
          obj = obj.parentNode;
        }
      } catch (e) {
        
      }
    }
  };

  render () {
    const { hover } = this.state;
    const { classes, program, genreId } = this.props;

    return (
      <div className={classes.root} onMouseMove={this.onMouseMove} data-type="program">
        {
          program.map(category => (
            <ProgramGroup 
              key={`category_${category.labelId}`} 
              genreId={genreId}
              category={category} 
              hover={hover}
            />
          ))
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
    backgroundColor: 'fcfcfc',
  }),
}))(ClassProgram);