const express = require("express");
const cors = require("cors");
const app = express();

var whitelist = ["http://localhost:8080", "http://frontend:8080"];

export const corsOptions = {
  origin: function (origin, callback) {
    if (whitelist.indexOf(origin) !== -1) {
      callback(null, true);
    } else {
      callback(new Error("Not allowed by CORS"));
    }
  },
};

app.use(express.json());
app.use("/", require("./route/postsRoute"));
app.use(function (error, req, res, next) {
  if (error.message === "Post already exists") {
    return res.status(409).send(e.message);
  }
  if (error.message === "Post not found") {
    return res.status(404).send(e.message);
  }
  res.status(500).send(error.message);
});

app.listen(3000);
