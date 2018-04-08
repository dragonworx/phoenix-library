import React from 'react';

export default class HoverGroup extends React.Component {
  state = {
    hover: null,
  };

  onMouseMove = e => {
    const target = e.target;
    const dataType = target.getAttribute('data-type');

    if (dataType === 'hover-group') {
      this.setState({ hover: null });
    } else {
      try {
        let obj = target;
        const dataType = target.getAttribute('data-type');
        const hoverValue = target.getAttribute('hover-value');
        while (obj && dataType !== 'hover-group') {
          if (dataType === 'hover-item') {
            this.setState({ hover: parseInt(hoverValue, 10) });
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
      <div {...others} onMouseMove={this.onMouseMove} data-type="hover-group">
        { render(this.state.hover) }
      </div>
    );
  }
}