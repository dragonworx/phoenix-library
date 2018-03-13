import React from "react";
import ReactDOM from 'react-dom';
import { MuiThemeProvider, createMuiTheme } from "material-ui/styles";

class App extends React.Component {
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
        {this.props.children}
      </MuiThemeProvider>
    );
  }
}

export default App;