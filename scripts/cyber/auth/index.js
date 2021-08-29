const axios = require('axios');
const fs = require('fs');
const parseArgs = require('minimist')

const args = parseArgs(process.argv.slice(2));

if (!args.tokenUrl) {
  throw Error('\'tokenUrl\' is required');
}

if (!args.envPath) {
  throw Error('\'envPath\' is required');
}

function getJSESSIONID(data) {
  const JSESSION_RE = /JSESSIONID=(\w+)/g;
  for (const cookie of data) {
    const match = JSESSION_RE.exec(cookie);
    if (match[1]) {
      return match[1];
    }
  }
}

function getAccessToken(data) {
  const re = /data-accesstoken=\s?"(\w+)"/g;
  const match = re.exec(data);
  if (match[1]) {
    return match[1];
  }
}

function getSessionId(data) {
  const re = /data-sessionid=\s?"(\w+)"/g;
  const match = re.exec(data);
  if (match[1]) {
    return match[1];
  }
}

async function getAuthenticationSession() {
  let res;
  let nextLocation;

  res = await axios.get(args.tokenUrl, {
    maxRedirects: 0,
    validateStatus: (status) => {
      return status === 303;
    }
  });

  const JSESSIONID = getJSESSIONID(res.headers['set-cookie']);

  nextLocation = res.headers.location;
  res = await axios.get(nextLocation, {
    maxRedirects: 0,
    validateStatus: (status) => {
      return status === 302;
    },
  });

  nextLocation = res.headers.location;
  res = await axios.get(nextLocation, {
    maxRedirects: 0,
    validateStatus: (status) => {
      return status === 302
    },
    headers: {
      Cookie: `JSESSIONID=${JSESSIONID}`,
    },
  });

  const AUTH_JSESSIONID = getJSESSIONID(res.headers['set-cookie']);
  res = await axios.get(args.tokenUrl, {
    maxRedirects: 0,
    validateStatus: (status) => {
      return status === 200
    },
    headers: {
      Cookie: `JSESSIONID=${AUTH_JSESSIONID}`,
    },
  });

  const accessToken = getAccessToken(res.data);
  const sessionId = getSessionId(res.data);
  fs.appendFile(args.envPath, `\nACCESS_TOKEN=${accessToken}\nSESSION_ID=${sessionId}`, (err) => {
    if (err) {
      console.error(err);
    }
  })
}

getAuthenticationSession();
