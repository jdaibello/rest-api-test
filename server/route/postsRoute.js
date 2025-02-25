const express = require("express");
const cors = require("cors");
const router = express.Router();
const postsService = require("../service/postsService");
const corsOptions = require("../server");

router.get("/posts", cors(corsOptions), async function (req, res, next) {
  try {
    const posts = await postsService.getPosts();
    res.json(posts);
  } catch (e) {
    next(e);
  }
});

router.post("/posts", cors(corsOptions), async function (req, res, next) {
  const post = req.body;
  try {
    const newPost = await postsService.savePost(post);
    res.status(201).json(newPost);
  } catch (e) {
    next(e);
  }
});

router.put("/posts/:id", cors(corsOptions), async function (req, res, next) {
  const post = req.body;
  try {
    await postsService.updatePost(req.params.id, post);
    res.status(204).end();
  } catch (e) {
    next(e);
  }
});

router.delete("/posts/:id", cors(corsOptions), async function (req, res, next) {
  try {
    await postsService.deletePost(req.params.id);
    res.status(204).end();
  } catch (e) {
    next(e);
  }
});

module.exports = router;
