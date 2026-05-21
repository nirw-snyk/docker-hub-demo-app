'use strict';

const express = require('express');

const app = express();
const port = Number(process.env.PORT) || 3000;
const appVersion = process.env.APP_VERSION || '1.2.0';

app.disable('x-powered-by');

app.get('/', (req, res) => {
  res.type('html').send(
    `<!DOCTYPE html>
<html lang="en">
<head><meta charset="utf-8"><title>Demo</title></head>
<body>
  <h1>docker-hub-demo</h1>
  <p>App version: <strong>${escapeHtml(appVersion)}</strong></p>
  <p>This image runs Node 22 on Bullseye; Express is pinned to an older release on purpose for dependency-focused security demos.</p>
</body>
</html>`
  );
});

app.get('/health', (req, res) => {
  res.json({ status: 'ok', version: appVersion });
});

app.listen(port, '0.0.0.0', () => {
  console.log(`listening on ${port}`);
});

function escapeHtml(s) {
  return String(s)
    .replace(/&/g, '&amp;')
    .replace(/</g, '&lt;')
    .replace(/>/g, '&gt;')
    .replace(/"/g, '&quot;');
}
