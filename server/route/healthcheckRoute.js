const express = require("express");
const router = express.Router();

router.get("/healthcheck", async function (req, res, next) {
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
