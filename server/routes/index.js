const express = require('express');
const router = express.Router();
const fs = require('fs');
const path = require('path');

const indexPath = path.resolve(__dirname, '../../build/index.html');
const indexHtml = fs.readFileSync(indexPath).toString();

router.post('/', function(req, res, next) {
  console.log("?")
  res.setHeader('Content-Type', 'text/html; charset=utf-8');
  res.send(indexHtml);
});

module.exports = router;