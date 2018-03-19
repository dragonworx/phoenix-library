import React from 'react';
import PropTypes from 'prop-types';
import { withStyles } from 'material-ui/styles';
import { CircularProgress } from 'material-ui/Progress';
import Button from 'material-ui/Button';
import SaveIcon from 'material-ui-icons/Save';
import styles from './styles';

class SaveButton extends React.Component {
  state = {
    loading: false,
    mode: 0,
  };

  handleButtonClick = () => {
    if (!this.state.loading) {
      this.setState({
        loading: true,
      }, () => {
        this.props.onClick()
          .then(() => this.setState({ loading: false, mode: 1 }))
          .catch(() => this.setState({ loading: false, mode: -1 }));
      });
    }
  };

  render() {
    const { loading, mode } = this.state;
    const { classes } = this.props;
    let buttonClassname = '';
    if (mode === -1) {
      buttonClassname = classes.buttonFail;
    } else if (mode === 1) {
      buttonClassname = classes.buttonSuccess;
    }

    return (
      <div className={classes.wrapper}>
        <Button
          variant="raised"
          color="primary"
          className={buttonClassname}
          disabled={loading}
          onClick={this.handleButtonClick}
        >
          Save
          <SaveIcon className={classes.rightIcon}>save</SaveIcon>
        </Button>
        {loading && <CircularProgress size={24} className={classes.buttonProgress} />}
      </div>
    );
  }
}

SaveButton.propTypes = {
  classes: PropTypes.object.isRequired,
};

export default withStyles(styles)(SaveButton);