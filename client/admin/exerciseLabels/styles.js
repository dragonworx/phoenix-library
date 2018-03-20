export default theme => ({
  root: {
    paddingTop: theme.spacing.unit * 3.75,
  },
  container: {
    width: '100%',
    maxWidth: 360,
    backgroundColor: theme.palette.background.paper,
    maxHeight: 275,
    minHeight: 275,
    minWidth: 300,
    overflow: 'auto',
    border: '1px solid #e7e7e7',
    marginTop: 5,
    borderRadius: 5,
  },
  nested: {
    paddingLeft: theme.spacing.unit * 4,
  },
  red: {
    backgroundColor: 'red'
  }
});