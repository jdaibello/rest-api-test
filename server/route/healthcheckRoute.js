const express = require("express");
const cors = require("cors");
const router = express.Router();

router.get("/healthcheck", cors(), async function (req, res, next) {
  const healthcheck = {
    message: "OK",
    timestamp: Date.now(),
  };
  try {
    res.status(200).send(healthcheck);
  } catch (error) {
    healthcheck.message = error;
    res.status(503).send();
  }
});

module.exports = router;
