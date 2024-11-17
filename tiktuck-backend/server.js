const express = require("express");
const mongoose = require("mongoose");
const cors = require("cors");
const Video = require("./models/video");
const multer = require("multer");
const path = require("path");

const app = express();

// Middleware CORS
app.use(
  cors({
    origin: "https://ticktuck-production.up.railway.app", // URL du frontend déployé
    methods: ["GET", "POST"],
    allowedHeaders: ["Content-Type"],
  })
);
// Middleware pour parser le JSON
app.use(express.json());
// Connexion à MongoDB
mongoose
  .connect(
    "mongodb://mongo:EiCmSqVVhWcGDNnkFSuOjQDhSnaPDaqL@mongodb.railway.internal:27017/ticktuck"
  )
  .then(() => console.log("Connecté à MongoDB"))
  .catch((err) => console.error("Erreur de connexion à MongoDB:", err));

// Configuration de Multer pour le stockage des vidéos
const storage = multer.diskStorage({
  destination: (req, file, cb) => {
    cb(null, "uploads/videos/");
  },
  filename: (req, file, cb) => {
    cb(null, Date.now() + path.extname(file.originalname)); // Nom unique pour chaque fichier
  },
});

const upload = multer({
  storage,
  limits: { fileSize: 100 * 1024 * 1024 }, // Limite de taille (ex: 100MB)
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
app.post("/upload", upload.single("video"), async (req, res) => {
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

// Route pour récupérer toutes les vidéos
app.get("/videos", async (req, res) => {
  try {
    const videos = await Video.find().sort({ createdAt: -1 });
    res.json(videos);
  } catch (err) {
    console.error("Erreur lors de la récupération des vidéos :", err);
    res.status(500).json({ error: err.message });
  }
});

// Servir les fichiers vidéo statiques
app.use("/videos", express.static(path.join(__dirname, "uploads/videos")));

// Gestion des erreurs Multer et autres erreurs
app.use((err, req, res, next) => {
  if (err instanceof multer.MulterError) {
    // Erreurs Multer
    console.error("Erreur Multer :", err);
    return res.status(500).json({ error: err.message });
  } else if (err) {
    // Autres erreurs
    console.error("Erreur :", err);
    return res.status(500).json({ error: err.message });
  }
  next();
});

// Démarrer le serveur
const PORT = 3000; // Port pour le serveur Express
const HOST = "0.0.0.0"; // Pour s'assurer que l'application est accessible

app.listen(PORT, HOST, () => {
  console.log(`Serveur backend démarré sur http://${HOST}:${PORT}`);
});
