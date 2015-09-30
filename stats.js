var http = require('http');
var https = require('https');
var promise = require('promise');
var request = function(options) {
  return new Promise(function(resolve, reject) {
    var client = (options.port === 443) ? https : http;
    var req = client.request(options, function(res) {
      res.setEncoding('utf8');
      var body = '';
      res.on('data', function(chunk) {
        body += '' + chunk;
      });
      res.on('end', function() {
        try {
          resolve(JSON.parse(body));
        } catch(err) {
          reject(err);
        }
      });
    });
    req.on('error', function(err) { reject(err); });
    req.end();
  });
};

Promise.all([
  request({
    hostname: 'img.shields.io',
    port: 80,
    path: '/$analytics/v1'
  }),
  request({
    hostname: 'img.shields.io',
    port: 443,
    path: '/$analytics/v1'
  }),
]).then(function(stats) {
  var sumType = function(a, b) {
    return a.map(function(e, i) { return e + b[i]; });
  };
  var httpTotals = sumType(stats[0].vendorMonthly, stats[0].rawMonthly);
  var httpsTotals = sumType(stats[1].vendorMonthly, stats[1].rawMonthly);
  var sum = function(a, b) { return a + b; };
  var httpTotal = httpTotals.reduce(sum);
  var httpsTotal = httpsTotals.reduce(sum);
  var total = httpTotal + httpsTotal;
  console.log(total);
}).catch(function(err) {
  throw err;
});
