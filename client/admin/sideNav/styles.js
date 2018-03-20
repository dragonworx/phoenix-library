const focusColor = '#ffc688';

module.exports = theme => ({
  root: {
    width: '100%',
    maxWidth: 360,
    backgroundColor: theme.palette.background.paper,
  },
  menuItem: {
    '&:focus': {
      backgroundColor: focusColor,
      '& $primary, & $icon': {
        color: theme.palette.common.white,
      },
    },
  },
  selected: {
    backgroundColor: focusColor,
    '& h3, & $icon': {
      color: 'white',
    }
  },
  link: {
    textDecoration: 'none',
  },
  primary: {},
  icon: {},
});