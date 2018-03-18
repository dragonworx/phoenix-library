import React from "react";
import ReactDOM from 'react-dom';
import { MuiThemeProvider, createMuiTheme } from "material-ui/styles";
import ErrorDialog from './errorDialog';

class App extends React.Component {
  state = {
    error: null
  };

  constructor (props) {
    super(props);
    window.onerror = (message, source, lineno, colno, error) => {
      this.setState({ error: (error && error.stack) || message });
    };
  }

  static render (Root) {
    ReactDOM.render(
      <App>
        <Root />
      </App>,
      document.body.appendChild(document.createElement('div'))
    );
  }

  render () {
    return (
      <MuiThemeProvider theme={createMuiTheme()}>
        {this.state.error ? <ErrorDialog message={this.state.error} /> : this.props.children}
      </MuiThemeProvider>
    );
  }
}

export default App;