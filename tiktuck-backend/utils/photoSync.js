const fs = require("fs");
const path = require("path");
const Photo = require("../models/photo"); // Importer le modèle Photo

// Chemin du dossier contenant les vidéos
//const photoDirectory = "/Volumes/SSD/Documents/photos";
const photoDirectory = "/Users/raphaelpierrot/Documents/Tiktuck/img";
async function saveExistingPhotosToDB() {
  try {
    const files = fs.readdirSync(photoDirectory).filter((file) => {
      return /\.(jpg|jpeg|png|gif)$/.test(file.toLowerCase());
    });

    const bulkOperations = files.map((file) => {
      const username = file.split("_")[0]; // Extraire le username avant le premier '_'
      const filePath = `/photos/${file}`; // Chemin relatif pour accéder à la photo

      return {
        updateOne: {
          filter: { photoUrl: filePath },
          update: {
            username: username,
            photoUrl: filePath,
          },
          upsert: true,
        },
      };
    });

    if (bulkOperations.length > 0) {
      const result = await Photo.bulkWrite(bulkOperations);
      console.log(
        `${result.upsertedCount} nouvelles photos ajoutées à la base de données.`
      );
    } else {
      console.log("Aucune nouvelle photo à ajouter.");
    }
  } catch (err) {
    console.error(
      "Erreur lors de la sauvegarde des photos dans la base de données :",
      err
    );
  }
}

module.exports = { saveExistingPhotosToDB };
