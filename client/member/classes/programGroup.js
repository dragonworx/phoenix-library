import React from "react";
import { withStyles } from "material-ui/styles";
import Paper from "material-ui/Paper";
import Typography from "material-ui/Typography";
import UpIcon from "material-ui-icons/KeyboardArrowUp";
import DownIcon from "material-ui-icons/KeyboardArrowDown";
import AddIcon from "material-ui-icons/AddCircle";
import RemoveIcon from "material-ui-icons/Cancel";
import IconButton from "material-ui/IconButton";
// import Tooltip from "material-ui/Tooltip";

class ProgramGroup extends React.PureComponent {
  state = {};

  render() {
    const { classes, category, onMoveUpClick, onMoveDownClick, onAddClick, onRemoveClick } = this.props;

    return (
      <Paper className={classes.root} elevation={4}>
        <Typography variant="title" component="p">
          {category.name}
        </Typography>
        <div className={classes.toolbar}>
          <IconButton variant="fab" color="primary" aria-label="add exercise" className={classes.button} onClick={() => onAddClick(category.id)}>
            <AddIcon />
          </IconButton>
          <IconButton variant="fab" color="primary" aria-label="move up" className={classes.button} onClick={onMoveUpClick}>
            <UpIcon />
          </IconButton>
          <IconButton variant="fab" color="primary" aria-label="move down" className={classes.button} onClick={onMoveDownClick}>
            <DownIcon />
          </IconButton>
          <IconButton variant="fab" color="primary" aria-label="remove category" className={classes.button} onClick={onRemoveClick}>
            <RemoveIcon />
          </IconButton>
        </div>
      </Paper>
    );
  }
}

export default withStyles(theme => ({
  root: theme.mixins.gutters({
    paddingTop: 16,
    paddingBottom: 16,
    marginTop: theme.spacing.unit * 3,
    position: "relative"
  }),
  button: {
    // margin: theme.spacing.unit,
  },
  toolbar: {
    position: "absolute",
    right: 0,
    top: 5
  }
}))(ProgramGroup);
