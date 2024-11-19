const express = require("express");
const mongoose = require("mongoose");
const cors = require("cors");
const { saveExistingVideosToDB } = require("./utils/videoSync");
const { saveExistingPhotosToDB } = require("./utils/photoSync");
const cron = require("node-cron");
const app = express();
const photoRoutes = require("./routes/photoRoutes");
const videoRoutes = require("./routes/videoRoutes");
const { cleanupMissingVideos } = require("./utils/cleanup");
const { Server } = require("socket.io");
const path = require("path");
const http = require("http");
const server = http.createServer(app);
const io = new Server(server, {
  cors: {
    origin: [
      "https://ticktuck-production.up.railway.app",
      "http://localhost:59419",
    ], // URL du frontend déployé
    methods: ["GET", "POST"],
  },
});
// Middleware CORS
app.use(
  cors({
    origin: [
      "https://ticktuck-production.up.railway.app",
      "http://localhost:59419",
    ], // URL du frontend déployé
    methods: ["GET", "POST"],
    allowedHeaders: ["Content-Type"],
  })
);
// Middleware pour parser le JSON
app.use(express.json());
// Connexion à MongoDB
mongoose
  .connect("mongodb://localhost:27017/tiktok-clone")
  .then(() => console.log("Connecté à MongoDB"))
  .catch((err) => console.error("Erreur de connexion à MongoDB:", err));

// Utiliser les routes
app.use("/api/photos", photoRoutes);
app.use("/api/videos", videoRoutes);
// Servir le frontend
const frontendPath = path.join(__dirname, "public"); // Dossier contenant les fichiers build de React ou Flutter Web
app.use(express.static(frontendPath));

// Route par défaut pour rediriger vers le frontend
app.get("*", (req, res) => {
  res.sendFile(path.join(frontendPath, "index.html"));
});

// Nettoyer la base de données au démarrage
cleanupMissingVideos();
saveExistingPhotosToDB();
saveExistingVideosToDB();

cron.schedule("0 * * * *", () => {
  console.log("Synchronisation des photos toutes les heures.");
  saveExistingPhotosToDB();
  saveExistingVideosToDB();
  // Planifier un nettoyage toutes les 24 heures
  console.log("Nettoyage quotidien de la base de données.");
  cleanupMissingVideos();
});
// Socket.IO pour notifications en temps réel
io.on("connection", (socket) => {
  console.log("Nouvelle connexion établie : ", socket.id);

  // Exemple : Émettre un événement lorsqu'une vidéo est ajoutée
  socket.on("newVideo", (data) => {
    io.emit("videoAdded", data);
  });

  socket.on("disconnect", () => {
    console.log("Déconnexion de : ", socket.id);
  });
});
// Démarrer le serveur
const PORT = 3000; // Port pour le serveur Express
const HOST = "0.0.0.0"; // Pour s'assurer que l'application est accessible

app.listen(PORT, HOST, () => {
  console.log(`Serveur backend démarré sur http://${HOST}:${PORT}`);
});
