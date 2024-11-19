const fs = require("fs");
const path = require("path");
const Video = require("../models/video"); // Modèle de vidéo
//const videoDirectory = "/Volumes/SSD/Documents/videos";
const videoDirectory = "../video";
async function cleanupMissingVideos() {
  try {
    const videos = await Video.find(); // Récupérer toutes les vidéos dans la base de données

    for (const video of videos) {
      const videoPath = path.join(
        videoDirectory,
        path.basename(video.videoUrl)
      );

      // Vérifier si le fichier vidéo existe
      if (!fs.existsSync(videoPath)) {
        console.log(
          `Fichier manquant : ${videoPath}, suppression de l'entrée BDD...`
        );

        // Supprimer l'entrée de la base de données
        await Video.findByIdAndDelete(video._id);
      }
    }

    console.log("Nettoyage terminé : suppression des vidéos inexistantes.");
  } catch (error) {
    console.error("Erreur lors du nettoyage des vidéos manquantes :", error);
  }
}

module.exports = { cleanupMissingVideos };
