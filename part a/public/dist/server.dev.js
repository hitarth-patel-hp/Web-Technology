"use strict";

var express = require('express');

var path = require('path');

var app = express();
var PORT = process.env.PORT || 3000; // Serve static files from this directory (the `public` folder contents)

app.use(express["static"](__dirname)); // Ensure the root path serves the index.html

app.get('/', function (req, res) {
  res.sendFile(path.join(__dirname, 'index.html'));
});
app.listen(PORT, function () {
  console.log("\uD83D\uDE80 Server running at http://localhost:".concat(PORT));
});