const mongoose = require("mongoose");

const photoSchema = new mongoose.Schema(
  {
    username: { type: String, required: true },
    description: { type: String, default: "Photo importée automatiquement" },
    likes: { type: Number, default: 0 },
    comments: { type: Number, default: 0 },
    photoUrl: { type: String, required: true },
  },
  { timestamps: true }
);

module.exports = mongoose.model("Photo", photoSchema);
