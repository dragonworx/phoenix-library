import React from 'react';
import Icon from 'material-ui-icons/Cloud';
import Tooltip from 'material-ui/Tooltip';
import { withStyles } from "material-ui/styles";
import axios from 'axios';
import styles from './styles';

const PING_INTERVAL_SECS = 30;

class PingStatus extends React.Component {
  state = {
    isConnected: true,
  };

  componentDidMount () {
    this.interval = setInterval(() => {
      axios.get('/ping').then(() => {
        this.setState({ isConnected: true });
      }).catch(() => {
        this.setState({ isConnected: false });
      });
    }, 1000 * PING_INTERVAL_SECS);
  }

  render () {
    const { classes } = this.props;
    const { isConnected } = this.state;

    return (
      <div className={classes.root}>
      <Tooltip title={isConnected ? 'Server is connected' : 'Server is disconnected, try reload page'} placement="left">
        {
          isConnected
            ? <Icon className={classes.online} />
            : <Icon className={classes.offline} />
        }
      </Tooltip>
      </div>
    );
  }
}

export default withStyles(styles)(PingStatus);