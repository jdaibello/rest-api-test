const express = require("express");
const cors = require("cors");
const app = express();

app.use(cors()); // Don't do this in production environment
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

app.listen(3000);
