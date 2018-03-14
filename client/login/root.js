import React from "react";
import { withStyles } from "material-ui/styles";
import Card, { CardActions, CardContent, CardMedia } from "material-ui/Card";
import Button from "material-ui/Button";
import Typography from "material-ui/Typography";
import { FormControl } from "material-ui/Form";
import Input, { InputLabel } from "material-ui/Input";
import axios from 'axios';

class SimpleMediaCard extends React.Component {
  state = {
    email: "",
    password: "",
    isValid: false
  };



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
    }).then(res => {
      console.log(res);
    });
  };

  render() {
    const { classes } = this.props;

    return (
      <div>
        <Card className={classes.card}>
          <CardMedia
            className={classes.media}
            image="img/logo-card.png"
            title="Phoenix Pilates"
          />
          <CardContent>
          <Typography variant="headline" component="h2">
            Exercise &amp; Class Library&copy;
            </Typography>
            <Typography component="p">
              Licenced to: <i>Excelsior&trade; Studios Erina</i>
            </Typography>
            <div className={classes.fields}>
            <FormControl className={classes.control}>
              <InputLabel htmlFor="email">Email</InputLabel>
              <Input
                id="email"
                value={this.state.email}
                onChange={this.onEmailChange}
              />
            </FormControl>
            <FormControl>
              <InputLabel htmlFor="password">Password</InputLabel>
              <Input
                id="password"
                value={this.state.password}
                onChange={this.onPasswordChange}
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
  fields: {
    display: 'flex',
    flexDirection: 'column'
  },
  card: {
    maxWidth: 345,
  },
  media: {
    height: 200
  },
})(SimpleMediaCard);
