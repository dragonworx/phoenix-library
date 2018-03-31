import React from "react";
import ReactDOM from 'react-dom';
import { MuiThemeProvider, createMuiTheme } from "material-ui/styles";

// const theme = createMuiTheme({
//   palette: {
//     primary: {
//       light: 'red',
//       main: 'orange',
//       dark: 'blue',
//       contrastText: '#fff',
//     },
//     secondary: {
//       light: '#ff7961',
//       main: '#f44336',
//       dark: '#ba000d',
//       contrastText: '#000',
//     },
//   },
// });

class App extends React.Component {
  state = {
    error: null
  };

  constructor (props) {
    super(props);
    window.onerror = (message, source, lineno, colno, error) => {
      document.write(`<pre style="padding: 10px; white-space: pre-wrap; color: white; background-color: #c66262; border: 2px dashed white;">${(error && error.stack) || message}</pre>`);
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
        {this.props.children}
      </MuiThemeProvider>
    );
  }
}

export default App;