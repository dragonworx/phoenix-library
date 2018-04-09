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

  mouseDown = false;

  componentWillMount () {
    hovers.push(this);
  }

  componentWillUnmount () {
    hovers.splice(hovers.indexOf(this), 1);
  }

  onMouseMove = async e => {
    if (this.mouseDown) {
      return;
    }
    
    const hover = this.state.hover;
    const target = e.target;
    const dataType = target.getAttribute('data-hover-type');

    if (dataType === 'group') {
      if (hover === null) {
        return;
      }
      await HoverGroup.resetAll();
      this.setState({ hover: null });
    } else {
      try {
        let obj = target;
        while (obj && obj.getAttribute('data-hover-type') !== 'group') {
          const dataType = obj.getAttribute('data-hover-type');
          const hoverValue = obj.getAttribute('data-hover-value');
          if (dataType === 'item') {
            const newHover = parseInt(hoverValue, 10);
            if (hover === newHover) {
              return;
            }
            await HoverGroup.resetAll();
            this.setState({ hover: newHover });
            return;
          }
          obj = obj.parentNode;
        }
      } catch (e) {
        
      }
    }
  };

  onMouseDown = () => {
    this.mouseDown = true;
    this.timeout = setTimeout(this.onMouseUp, 250);
  };

  onMouseUp = () => {
    this.mouseDown = false;
    clearTimeout(this.timeout);
  };

  render () {
    const { render, ...others } = this.props;

    return (
      <div {...others} onMouseMove={this.onMouseMove} onMouseDown={this.onMouseDown} data-hover-type="group" style={{ position: 'relative' }}>
        { render(this.state.hover) }
      </div>
    );
  }
}