import React from 'react';
import { withStyles } from 'material-ui/styles';
import green from 'material-ui/colors/green';
import red from 'material-ui/colors/red';
import { multi } from '../../common/util';

const DEFAULT_BORDER = '2px solid #b9b9b9';

class LightLink extends React.Component {
  render () {
    const { classes, row } = this.props;
    const { id, photo } = row;
    const cache = `?now=${Date.now()}`;
    // eslint-disable-next-line no-undef
    const thumbnailUrl = `${PHOENIX_LIB_STORAGE}${id}_1_thumb.png`;
    
    return (
      <span className={multi(classes.dropZoneContainer, classes.round)}>
        {
          photo
            ? <img title={photo} className={multi(classes.dropZoneImg, classes.round)} src={`${thumbnailUrl}${cache}`} />
            : <img title="No image set" className={multi(classes.dropZoneImg, classes.round)} src="/img/image-placeholder.png" />
        }
      </span>
    );
  }
};

export default withStyles({
  dropZoneContainer: {
    display: 'inline-block',
    position: 'relative',
    width: 52,
    height: 52,
    display: 'flex',
    alignItems: 'center',
    justifyContent: 'center',
  },
  dropZoneImg: {
    maxWidth: 48,
    maxHeight: 48,
    boxShadow: '1px 8px 10px -4px rgba(0,0,0,0.3)',
    border: DEFAULT_BORDER
  },
  round: {
    borderRadius: 5,
  },
  progress: {
    color: green[500],
    position: 'absolute',
    top: '50%',
    left: '50%',
    marginTop: -24,
    marginLeft: -24,
  },
  error: {
    color: red[500],
    position: 'absolute',
    top: '50%',
    left: '50%',
    marginTop: -24,
    marginLeft: -24,
  },
})(LightLink);