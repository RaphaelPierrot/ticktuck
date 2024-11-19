const express = require("express");
const mongoose = require("mongoose");
const cors = require("cors");
const { saveExistingVideosToDB } = require("./utils/videoSync");
const { saveExistingPhotosToDB } = require("./utils/photoSync");
const cron = require("node-cron");
const app = express();
const photoRoutes = require("./routes/photoRoutes");
const videoRoutes = require("./routes/videoRoutes");
// Middleware CORS
app.use(
  cors({
    origin: [
      "https://ticktuck-production.up.railway.app",
      "http://localhost:56701",
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
saveExistingPhotosToDB();
saveExistingVideosToDB();
cron.schedule("0 * * * *", () => {
  console.log("Synchronisation des photos toutes les heures.");
  saveExistingPhotosToDB();
  saveExistingVideosToDB();
});

// Démarrer le serveur
const PORT = 3000; // Port pour le serveur Express
const HOST = "0.0.0.0"; // Pour s'assurer que l'application est accessible

app.listen(PORT, HOST, () => {
  console.log(`Serveur backend démarré sur http://${HOST}:${PORT}`);
});
