const express = require("express");
const multer = require("multer");
const path = require("path");
const Photo = require("../models/photo");

const router = express.Router();
// Chemin du dossier contenant les vidéos
//const photoDirectory = "/Volumes/SSD/Documents/photos";
const photoDirectory = "../img";
// Configuration de Multer pour les photos
const storage = multer.diskStorage({
  destination: (req, file, cb) => {
    cb(null, photoDirectory); // Stockage sur SSD externe
  },
  filename: (req, file, cb) => {
    cb(null, Date.now() + path.extname(file.originalname)); // Nom unique
  },
});

const upload = multer({
  storage,
  limits: { fileSize: 1000 * 1024 * 1024 }, // Limite de 1GB par fichier
  fileFilter: (req, file, cb) => {
    const fileTypes = /jpeg|jpg|png|gif/;
    const extname = fileTypes.test(
      path.extname(file.originalname).toLowerCase()
    );
    const mimeType = fileTypes.test(file.mimetype);

    if (mimeType && extname) {
      return cb(null, true);
    } else {
      cb(
        new Error(
          "Seuls les fichiers image sont autorisés (jpeg, jpg, png, gif)"
        )
      );
    }
  },
});

// Route pour télécharger une photo
router.post("/upload", upload.single("photo"), async (req, res) => {
  try {
    if (!req.file) {
      return res.status(400).json({ error: "Aucun fichier photo reçu" });
    }

    const newPhoto = new Photo({
      username: req.body.username,
      description: req.body.description || "Pas de description",
      likes: 0,
      comments: 0,
      shares: 0,
      photoUrl: `/photos/${req.file.filename}`,
    });

    await newPhoto.save();
    res.status(201).json(newPhoto);
  } catch (err) {
    console.error("Erreur lors du téléchargement de la photo :", err);
    res.status(500).json({ error: err.message });
  }
});

// Route pour récupérer toutes les photos
router.get("/", async (req, res) => {
  try {
    const photos = await Photo.find().sort({ createdAt: -1 });
    res.json(photos);
  } catch (err) {
    console.error("Erreur lors de la récupération des photos :", err);
    res.status(500).json({ error: err.message });
  }
});

// Route pour récupérer une photo par ID
router.get("/:id", async (req, res) => {
  try {
    const photo = await Photo.findById(req.params.id);
    if (!photo) {
      return res.status(404).json({ error: "Photo non trouvée" });
    }
    res.json(photo);
  } catch (err) {
    console.error("Erreur lors de la récupération de la photo :", err);
    res.status(500).json({ error: err.message });
  }
});

// Route pour liker une photo
router.post("/:id/like", async (req, res) => {
  try {
    const photo = await Photo.findByIdAndUpdate(
      req.params.id,
      { $inc: { likes: 1 } },
      { new: true }
    );
    if (!photo) {
      return res.status(404).json({ error: "Photo non trouvée" });
    }
    res.json(photo);
  } catch (err) {
    console.error("Erreur lors du like de la photo :", err);
    res.status(500).json({ error: err.message });
  }
});

// Route pour supprimer une photo
router.delete("/:id", async (req, res) => {
  try {
    const photo = await Photo.findByIdAndDelete(req.params.id);
    if (!photo) {
      return res.status(404).json({ error: "Photo non trouvée" });
    }
    res.json({ message: "Photo supprimée avec succès" });
  } catch (err) {
    console.error("Erreur lors de la suppression de la photo :", err);
    res.status(500).json({ error: err.message });
  }
});
// Servir les fichiers photo statiques
router.use("/", express.static(path.join(photoDirectory)));

module.exports = router;
