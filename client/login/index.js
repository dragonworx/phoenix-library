import React from "react";
import { withStyles } from "material-ui/styles";
import Card, { CardActions, CardContent, CardMedia } from "material-ui/Card";
import Button from "material-ui/Button";
import Typography from "material-ui/Typography";
import { FormControl } from "material-ui/Form";
import Input, { InputLabel } from "material-ui/Input";
import axios from 'axios';

class Login extends React.Component {
  state = {
    email: 'magnoliasoup@gmail.com',
    password: 'Copacabana1',
    isValid: false,
    loginFail: false,
  };

  constructor (props) {
    super(props);
    this.state.isValid = !!(this.state.email || this.state.password);
  }

  onEmailChange = event => {
    const value = event.target.value;
    this.setState({
      email: value,
      isValid: value || this.state.password
    });
  };

  onPasswordChange = event => {
    const value = event.target.value;
    this.setState({
      password: event.target.value,
      isValid: value || this.state.email
    });
  };

  onLogin = () => {
    axios.post('/login', {
      email: this.state.email,
      password: this.state.password
    }).then(() => {
      location = '/admin/land';
    }).catch(() => {
      this.setState({ loginFail: true });
      setTimeout(() => this.setState({ loginFail: false }), 1000)
    });
  };

  onKeyUp = e => {
    if (e.keyCode === 13) {
      this.onLogin();
    }
  };

  render() {
    const { classes } = this.props;

    return (
      <div className={this.state.loginFail ? 'error' : ''}>
        <Card className={classes.card}>
          <CardMedia
            className={classes.media}
            image="img/logo-card.png"
            title="Phoenix Pilates"
          />
          <CardContent>
          <Typography variant="headline" component="h2">
            Exercise &amp; Class Library
            </Typography>
            <Typography component="p" className={classes.licence}>
              Licenced to: <i>Excelsior&trade; Studios Erina</i>
            </Typography>
            <div className={classes.fields}>
              {
                this.state.loginFail ?
                  <Typography component="p" className={classes.error}>
                    Incorrect
                  </Typography>
                  : <span>&nbsp;</span>
              }
              <FormControl className={classes.control}>
                <InputLabel htmlFor="email">Email</InputLabel>
                <Input
                  id="email"
                  value={this.state.email}
                  onChange={this.onEmailChange}
                  onKeyUp={this.onKeyUp}
                />
              </FormControl>
              <FormControl>
                <InputLabel htmlFor="password">Password</InputLabel>
                <Input
                  id="password"
                  value={this.state.password}
                  onChange={this.onPasswordChange}
                  onKeyUp={this.onKeyUp}
                  type="password"
                />
              </FormControl>
            </div>
          </CardContent>
          <CardActions className={classes.right}>
            <Button disabled={!this.state.isValid} size="small" color="primary" onClick={this.onLogin}>
              Login
            </Button>
          </CardActions>
        </Card>
      </div>
    );
  }
}

export default withStyles({
  right: {
    justifyContent: 'flex-end'
  },
  licence: {
    textAlign: 'center',
    color: '#e99700',
  },
  fields: {
    display: 'flex',
    flexDirection: 'column',
  },
  card: {
    maxWidth: 345,
  },
  media: {
    height: 200
  },
  error: {
    color: 'orange',
    fontStyle: 'italic',
    textAlign: 'center',
    color: 'white',
    backgroundColor: 'orange',
    borderRadius: '10px',
    marginBottom: '1px',
  }
})(Login);
