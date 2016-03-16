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

var mergeArray = function(a1, a2) {
  var len = a1.length;
  for (var i = 0; i < len; i++) {
    a1[i] += a2[i];
  }
  return a1;
};
var mergeStats = function(stat, stat2) {
  for (var key in stat) {
    if (Object(stat[key]) instanceof Array) {
      stat[key] = mergeArray(stat[key], stat2[key]);
    } else if (Object(stat[key]) instanceof Object) {
      stat[key] = mergeStats(stat[key], stat2[key]);
    }
  }
  return stat;
};

var stats;
request({
  hostname: 'vps197850.ovh.net',
  port: 443,
  rejectUnauthorized: false,
  path: '/$analytics/v1'
}).then(function(stats1) {
  stats = stats1;
  return request({
    hostname: 'vps244529.ovh.net',
    port: 443,
    rejectUnauthorized: false,
    path: '/$analytics/v1'
  });
}).then(function(stats2) {
  stats = mergeStats(stats, stats2);
  var sumType = function(a, b) {
    return a.map(function(e, i) { return e + b[i]; });
  };
  var httpsTotals = sumType(stats.vendorMonthly, stats.rawMonthly);
  var sum = function(a, b) { return a + b; };
  var httpsTotal = httpsTotals.reduce(sum);
  var total = httpsTotal;
  console.log(total);
}).catch(function(err) {
  console.error(err.stack);
  throw err;
});
