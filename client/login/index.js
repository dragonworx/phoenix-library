import React from "react";
import { withStyles } from "material-ui/styles";
import Card, { CardActions, CardContent, CardMedia } from "material-ui/Card";
import Button from "material-ui/Button";
import Typography from "material-ui/Typography";
import { FormControl } from "material-ui/Form";
import Input, { InputLabel } from "material-ui/Input";
import axios from 'axios';

const LICENCED_TO = 'Excelsior™ Studios Erina';

// eslint-disable-next-line no-undef
const VERSION = PHOENIX_LIB_VERSION;

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
        <Card className={classes.card} raised={true}>
          <CardMedia
            className={classes.media}
            image="img/logo-card.png"
            title="Phoenix Pilates"
          />
          <CardContent>
          <Typography variant="headline" component="h2" className={classes.title}>
            Exercise &amp; Class Library&copy;
            </Typography>
            <Typography component="p" className={classes.licence}>
              <span className={classes.licencedTo}>Licenced to:</span>
              <span className={classes.licencee}>{LICENCED_TO}</span>
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
          <span className={classes.version}>v{VERSION}</span>
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
    position: 'relative',
    borderRadius: 12,
  },
  media: {
    height: 200,
    borderRadius: 20,
  },
  error: {
    color: 'orange',
    fontStyle: 'italic',
    textAlign: 'center',
    color: 'white',
    backgroundColor: 'orange',
    borderRadius: '10px',
    marginBottom: '1px',
  },
  licencedTo: {
    color: '#ccc',
    display: 'block',
  },
  licencee: {
    color: 'orange',
    display: 'block',
  },
  version: {
		left: 26,
		color: 'orange',
		bottom: 14,
		position: 'absolute',
		fontSize: '80%',
  },
  title: {
    color: 'rgb(255, 255, 255)',
		padding: '10px 19px',
		fontSize: '140%',
		boxShadow: 'inset 0 0 10px #b5580a',
		textAlign: 'center',
		background: 'linear-gradient(180deg, #ffd903 0, #ff8901 100%)',
		fontWeight: 400,
		borderRadius: 50,
		marginBottom: 20,
  }
})(Login);
