const mongoose = require("mongoose");

const videoSchema = new mongoose.Schema({
  username: String,
  description: String,
  music: String,
  likes: Number,
  comments: Number,
  shares: Number,
  videoUrl: String, // URL pour accéder à la vidéo
  createdAt: {
    type: Date,
    default: Date.now,
  },
});

module.exports = mongoose.model("Video", videoSchema);
