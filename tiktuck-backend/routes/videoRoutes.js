const express = require("express");
const multer = require("multer");
const path = require("path");
const Video = require("../models/video");

const router = express.Router();
// Chemin du dossier contenant les vidéos
//const videoDirectory = "/Volumes/SSD/Documents/videos";
const videoDirectory = "/Users/raphaelpierrot/Documents/Tiktuck/video";
// Configuration de Multer pour le stockage des vidéos sur le SSD externe
const storage = multer.diskStorage({
  destination: (req, file, cb) => {
    cb(null, videoDirectory); // Dossier sur le SSD externe
  },
  filename: (req, file, cb) => {
    cb(null, Date.now() + path.extname(file.originalname)); // Nom unique pour chaque fichier
  },
});

const upload = multer({
  storage,
  limits: { fileSize: 2000 * 1024 * 1024 }, // Limite de taille (2 GB)
  fileFilter: (req, file, cb) => {
    const fileTypes = /mp4|mov|avi|mkv/;
    const extname = fileTypes.test(
      path.extname(file.originalname).toLowerCase()
    );
    const mimeType = fileTypes.test(file.mimetype);

    if (mimeType && extname) {
      return cb(null, true);
    } else {
      cb(new Error("Seuls les fichiers vidéo sont autorisés"));
    }
  },
});

// Route pour télécharger une nouvelle vidéo
router.post("/upload", upload.single("video"), async (req, res) => {
  try {
    if (!req.file) {
      console.error("Aucun fichier reçu");
      return res.status(400).json({ error: "Aucun fichier vidéo reçu" });
    }

    console.log("Fichier reçu :", req.file.filename);

    const newVideo = new Video({
      username: req.body.username,
      description: req.body.description,
      music: req.body.music,
      likes: 0,
      comments: 0,
      shares: 0,
      videoUrl: `/videos/${req.file.filename}`,
    });

    await newVideo.save();
    res.status(201).json(newVideo);
  } catch (err) {
    console.error("Erreur lors du téléchargement de la vidéo :", err);
    res.status(500).json({ error: err.message });
  }
});
// Route GET pour récupérer toutes les vidéos
router.get("/", async (req, res) => {
  try {
    const videos = await Video.find().sort({ createdAt: -1 });
    res.json(videos);
  } catch (err) {
    console.error("Erreur lors de la récupération des vidéos :", err);
    res
      .status(500)
      .json({ error: "Erreur lors de la récupération des vidéos" });
  }
});
// Route pour récupérer toutes les vidéos
router.get("/videos", async (req, res) => {
  try {
    const videos = await Video.find().sort({ createdAt: -1 });
    res.json(videos);
  } catch (err) {
    console.error("Erreur lors de la récupération des vidéos :", err);
    res.status(500).json({ error: err.message });
  }
});

// Gestion des erreurs Multer et autres erreurs
router.use((err, req, res, next) => {
  if (err instanceof multer.MulterError) {
    console.error("Erreur Multer :", err);
    return res.status(500).json({ error: err.message });
  } else if (err) {
    console.error("Erreur :", err);
    return res.status(500).json({ error: err.message });
  }
  next();
});
// Servir les fichiers vidéo statiques
router.use("/static", express.static(path.join(videoDirectory)));

module.exports = router;
