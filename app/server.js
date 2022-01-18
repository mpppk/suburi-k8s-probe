const express = require("express");
const app = express();
const port = process.env["PORT"] || 3000;

app.get("/healthz", (req, res) => {
  res.send("OK");
});

// 起動に時間がかかるアプリをシミュレート
setTimeout(() => {
  app.listen(port, () => {
    console.log(`Example app listening at http://localhost:${port}`);
  });
}, 1000 * 10);
