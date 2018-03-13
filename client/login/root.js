import React from "react";
import PropTypes from "prop-types";
import { withStyles } from "material-ui/styles";
import Card, { CardActions, CardContent, CardMedia } from "material-ui/Card";
import Button from "material-ui/Button";
import Typography from "material-ui/Typography";
import { FormControl, FormHelperText } from "material-ui/Form";
import Input, { InputLabel } from "material-ui/Input";
import axios from 'axios';

const styles = {
  card: {
    maxWidth: 345,
    margin: 'auto',
    marginTop: '10%'
  },
  media: {
    height: 200
  },
};

class SimpleMediaCard extends React.Component {
  state = {
    email: "",
    password: "",
  };

  onEmailChange = event => {
    this.setState({
      email: event.target.value
    });
  };

  onPasswordChange = event => {
    this.setState({
      password: event.target.value
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
              Excelsior
            </Typography>
            <Typography component="p">
              Exercise &amp; Class Library
            </Typography>
            <br />
            <FormControl>
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
          </CardContent>
          <CardActions>
            <Button size="small" color="primary" onClick={this.onLogin}>
              Login
            </Button>
          </CardActions>
        </Card>
      </div>
    );
  }
}

SimpleMediaCard.propTypes = {
  classes: PropTypes.object.isRequired
};

export default withStyles(styles)(SimpleMediaCard);
