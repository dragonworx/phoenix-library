import React from 'react';

const hovers = [];

export default class HoverGroup extends React.Component {
  static resetAll () {
    const promises = hovers.map(instance => new Promise((resolve) => {
      instance.setState({ hover: null }, () => resolve());
    }));
    return Promise.all(promises);
  }

  state = {
    hover: null,
  };

  componentWillMount () {
    hovers.push(this);
  }

  componentDidlMount () {
    hovers.splice(hovers.indexOf(this), 1);
  }

  onMouseMove = async e => {
    const target = e.target;
    const dataType = target.getAttribute('data-hover-type');

    if (dataType === 'group') {
      await HoverGroup.resetAll();
      this.setState({ hover: null });
    } else {
      try {
        let obj = target;
        while (obj && obj.getAttribute('data-hover-type') !== 'group') {
          const dataType = obj.getAttribute('data-hover-type');
          const hoverValue = obj.getAttribute('data-hover-value');
          if (dataType === 'item') {
            await HoverGroup.resetAll();
            this.setState({ hover: parseInt(hoverValue, 10) });
            return;
          }
          obj = obj.parentNode;
        }
      } catch (e) {
        
      }
    }
  };

  render () {
    const { render, ...others } = this.props;

    return (
      <div {...others} onMouseMove={this.onMouseMove} data-hover-type="group" style={{ position: 'relative' }}>
        { render(this.state.hover) }
      </div>
    );
  }
}