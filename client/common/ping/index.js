import React from 'react';
import Icon from 'material-ui-icons/Cloud';
import Tooltip from 'material-ui/Tooltip';
import { withStyles } from "material-ui/styles";
import axios from 'axios';
import { user } from '../../member/session';

const PING_INTERVAL_SECS = 30;

// eslint-disable-next-line no-undef
const VERSION = PHOENIX_LIB_VERSION;

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
    const title = `v${VERSION} ~ ${isConnected ? ' Server is connected' : 'Server is disconnected, try reloading page'}`;

    return (
      <div className={classes.root}>
        <Tooltip title={title} placement="left">
          {
            isConnected
              ? <Icon className={classes.online} />
              : <Icon className={classes.offline} />
          }
        </Tooltip>
        <div className={classes.title}>
        {user.firstName}
        </div>
      </div>
    );
  }
}

export default withStyles({
  root: {
    position: 'absolute',
    bottom: 22,
    right: 43,
  },
  online: {
    color: 'white',
  },
  offline: {
    color: 'red'
  },
  title: {
    position: 'absolute',
    top: 0,
    right: 35,
  }
})(PingStatus);