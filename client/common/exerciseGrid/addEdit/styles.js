export default theme => ({
  descLabel: {
    marginTop: theme.spacing.unit * 3,
    marginBottom: theme.spacing.unit,
  },
  editor: {
    border: '1px solid #b2b2b2',
    borderRadius: '5px',
    padding: '5px',
    fontSize: '80%',
  },
  flex: {
    padding: theme.spacing.unit * 3,
    flex: 1,
  },
  content: {
    marginTop: theme.spacing.unit * 3,
    flexGrow: 1,
    width: 700,
  },
  snackbar: {
    position: 'absolute',
  },
  snackbarContent: {
    width: 360,
  }
});