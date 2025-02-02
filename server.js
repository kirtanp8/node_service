const express = require("express");
const auth = require("basic-auth");
require("dotenv").config();

const app = express();
const PORT = process.env.PORT || 3000;

// Route - Public
app.get("/", (req, res) => {
  res.send("Hello, world!");
});

// Route - Protected
app.get("/secret", (req, res) => {
  const credentials = auth(req);

  if (!credentials || credentials.name !== process.env.USERNAME || credentials.pass !== process.env.PASSWORD) {
    res.status(401).send("Access denied");
    return;
  }

  res.send(`Secret message: ${process.env.SECRET_MESSAGE}`);
});

// Start server
app.listen(PORT, () => {
  console.log(`Server running on http://localhost:${PORT}`);
});
