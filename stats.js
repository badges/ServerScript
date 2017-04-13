let http = require('http');
let https = require('https');

const servers = [
  'vps71670.vps.ovh.ca',
  'vps244529.ovh.net',
  'vps117870.vps.ovh.ca',
];

function request(options) {
  return new Promise((resolve, reject) => {
    let client = (options.port === 443) ? https : http;
    let req = client.request(options, res => {
      res.setEncoding('utf8');
      let body = '';
      res.on('data', chunk => {
        body += '' + chunk;
      });
      res.on('end', () => {
        try {
          resolve(JSON.parse(body));
        } catch(err) {
          reject(err);
        }
      });
    });
    req.on('error', reject);
    req.end();
  });
}

function mergeArrays(arrays) {
  return arrays.reduce((acc, array) =>
    acc.map((item, i) => item + array[i]));
}

function mergeStats(stats) {
  return stats.reduce((acc, stat) => {
    for (const key in acc) {
      if (Object(acc[key]) instanceof Array) {
        acc[key] = mergeArrays([acc[key], stat[key]]);
      } else if (Object(acc[key]) instanceof Object) {
        acc[key] = mergeStats([acc[key], stat[key]]);
      }
    }
    return acc;
  });
};

function getServerAnalytics(server) {
  return request({
    hostname: server,
    port: 443,
    rejectUnauthorized: false,
    path: '/$analytics/v1'
  });
}

Promise.all(servers.map(getServerAnalytics))
.then(stats => {
  let stat = mergeStats(stats);
  let dailyTotal = mergeArrays([stat.vendorMonthly, stat.rawMonthly]);
  let monthlyTotal = dailyTotal.reduce((a, b) => a + b);
  console.log(monthlyTotal);
})
.catch(err => {console.error(err); process.exit(1)});
