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

request({
  hostname: 'img.shields.io',
  port: 443,
  path: '/$analytics/v1'
}).then(function(stats) {
  var sumType = function(a, b) {
    return a.map(function(e, i) { return e + b[i]; });
  };
  var httpsTotals = sumType(stats.vendorMonthly, stats.rawMonthly);
  var sum = function(a, b) { return a + b; };
  var httpsTotal = httpsTotals.reduce(sum);
  var total = httpsTotal;
  console.log(total);
}).catch(function(err) {
  throw err;
});
