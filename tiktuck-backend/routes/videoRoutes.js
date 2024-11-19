const express = require("express");
const multer = require("multer");
const path = require("path");
const Video = require("../models/video");

const router = express.Router();
// Chemin du dossier contenant les vidéos
//const videoDirectory = "/Volumes/SSD/Documents/videos";
const videoDirectory = "../video";
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
    // Émettre un événement via Socket.IO
    req.app.get("io").emit("videoAdded", newVideo);
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
// Route pour supprimer une vidéo
router.delete("/:id", async (req, res) => {
  try {
    const videoId = req.params.id;

    // Rechercher la vidéo dans la base de données
    const video = await Video.findById(videoId);
    if (!video) {
      return res.status(404).json({ message: "Vidéo non trouvée" });
    }

    // Chemin complet de la vidéo sur le disque
    const videoPath = path.join(videoDirectory, path.basename(video.videoUrl));

    // Supprimer le fichier vidéo du système de fichiers
    fs.unlink(videoPath, (err) => {
      if (err) {
        console.error("Erreur lors de la suppression du fichier :", err);
        return res
          .status(500)
          .json({ message: "Erreur lors de la suppression du fichier vidéo" });
      }

      console.log("Fichier vidéo supprimé :", videoPath);
    });

    // Supprimer l'entrée de la vidéo dans la base de données
    await Video.findByIdAndDelete(videoId);

    res.status(200).json({ message: "Vidéo supprimée avec succès" });
  } catch (error) {
    console.error("Erreur lors de la suppression de la vidéo :", error);
    res
      .status(500)
      .json({ message: "Erreur lors de la suppression de la vidéo" });
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
router.use("/", express.static(path.join(videoDirectory)));

module.exports = router;