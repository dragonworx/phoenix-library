import React from 'react';
import Icon from 'material-ui-icons/Cloud';
import Tooltip from 'material-ui/Tooltip';
import { withStyles } from "material-ui/styles";
import axios from 'axios';

const PING_INTERVAL_SECS = 30;

class PingStatus extends React.Component {
  state = {
    isConnected: true,
  };

  ping = () => {
    axios.get('/ping').then(() => {
      this.setState({ isConnected: true });
    }).catch(() => {
      this.setState({ isConnected: false });
    });
  };

  componentDidMount () {
    this.ping();
    this.interval = setInterval(this.ping, 1000 * PING_INTERVAL_SECS);
  }

  render () {
    const { classes } = this.props;
    const { isConnected } = this.state;
    const title = `v${PHOENIX_LIB_VERSION} ~ ${isConnected ? ' Server is connected' : 'Server is disconnected, try reloading page'}`;

    return (
      <div className={classes.root}>
      <Tooltip title={title} placement="left">
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

export default withStyles({
  root: {
    position: 'absolute',
    bottom: 2,
    right: 6,
  },
  online: {
    color: 'white',
  },
  offline: {
    color: 'red'
  },
})(PingStatus);