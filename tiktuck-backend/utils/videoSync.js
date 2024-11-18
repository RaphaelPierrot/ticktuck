const fs = require("fs/promises");
const path = require("path");
const Video = require("../models/video");
const { Worker } = require("worker_threads");

// Chemin du dossier contenant les vidéos
//const videoDirectory = "/Volumes/SSD/Documents/videos";
const videoDirectory = "/Users/raphaelpierrot/Documents/Tiktuck/video";
// Fonction pour extraire le username avant le premier underscore
function extractUsername(filename) {
  const underscoreIndex = filename.indexOf("_");
  return underscoreIndex !== -1
    ? filename.substring(0, underscoreIndex)
    : "default_user";
}

// Fonction pour traiter un fichier et l'enregistrer dans la base
async function processVideo(file) {
  const ext = path.extname(file).toLowerCase();
  if (![".mp4", ".mov", ".avi", ".mkv"].includes(ext)) return;

  const videoUrl = `/videos/${file}`;
  const username = extractUsername(file);

  // Vérifier si la vidéo existe déjà dans la base
  const existingVideo = await Video.findOne({ videoUrl });
  if (existingVideo) {
    console.log(`Vidéo ${file} déjà enregistrée.`);
    return;
  }

  const newVideo = new Video({
    username: username,
    description: "Description par défaut",
    music: "Musique par défaut",
    likes: 0,
    comments: 0,
    shares: 0,
    videoUrl: videoUrl,
  });

  await newVideo.save();
  console.log(`Vidéo ${file} enregistrée avec succès.`);
}

// Fonction principale pour traiter les vidéos en parallèle
async function saveExistingVideosToDB(concurrency = 10) {
  try {
    const files = await fs.readdir(videoDirectory);
    const queue = files.filter((file) =>
      [".mp4", ".mov", ".avi", ".mkv"].includes(
        path.extname(file).toLowerCase()
      )
    );

    console.log(`Début du traitement de ${queue.length} vidéos...`);

    const workerPool = [];
    for (let i = 0; i < queue.length; i += concurrency) {
      const batch = queue.slice(i, i + concurrency);
      const tasks = batch.map((file) => processVideo(file));
      workerPool.push(Promise.all(tasks));
    }

    await Promise.all(workerPool);

    console.log("Toutes les vidéos ont été traitées.");
  } catch (err) {
    console.error("Erreur lors du traitement des vidéos :", err);
  }
}
module.exports = { saveExistingVideosToDB };
