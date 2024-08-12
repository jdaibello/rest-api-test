const express = require("express");
// const cors = require("cors");
const dotenv = require("dotenv");

dotenv.config();

const app = express();

var whitelist = [
  "http://localhost:8080",
  "http://frontend:8080",
  "http://www.test-joao-daibello-frontend-website.s3-website.us-east-2.amazonaws.com",
  "https://d5xvmmbj7nefw.cloudfront.net"
];

const corsOptions = {
  origin: function (origin, callback) {
    if (whitelist.indexOf(origin) !== -1) {
      callback(null, true);
    } else {
      callback(new Error("Not allowed by CORS"));
    }
  },
};

// app.use(cors(corsOptions));

app.use(express.json());
app.use("/", require("./route/postsRoute"));
app.use("/", require("./route/healthcheckRoute"));

app.use(function (error, req, res, next) {
  if (error.message === "Post already exists") {
    return res.status(409).send(e.message);
  }

  if (error.message === "Post not found") {
    return res.status(404).send(e.message);
  }

  res.status(500).send(error.message);
});

app.listen(process.env.SERVER_PORT || 3000);

module.exports = corsOptions;
