var coverage = require('nyc-middleware');
var express = require('express');
var app = express();

app.use('/', coverage.createHandler());

app.listen(8888);
