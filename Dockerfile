# Étape 1: Build de l'application Flutter
FROM ghcr.io/cirruslabs/flutter:3.2.2 AS flutter-build

WORKDIR /app

# Copier les fichiers nécessaires pour les dépendances
COPY pubspec.* ./

# Installer les dépendances Flutter
RUN flutter pub get

# Copier tout le projet Flutter
COPY . .

# Construire le projet Flutter pour le web
RUN flutter build web

# Étape 2: Configuration du back-end Node.js
FROM node:18-alpine AS backend-build

WORKDIR /app

# Copier le back-end uniquement
COPY tiktuck-backend/package*.json ./tiktuck-backend/

# Installer les dépendances du back-end
RUN cd tiktuck-backend && npm install

# Copier le reste des fichiers du back-end
COPY tiktuck-backend ./tiktuck-backend

# Étape 3: Serveur final
FROM nginx:stable-alpine

WORKDIR /usr/share/nginx/html

# Copier les fichiers construits par Flutter (front-end)
COPY --from=flutter-build /app/build/web/ .

# Configurer Nginx pour servir l'application Flutter et rediriger les API
COPY ./nginx.conf /etc/nginx/conf.d/default.conf

# Copier le back-end
WORKDIR /app
COPY --from=backend-build /app/tiktuck-backend .

# Exposer le port pour Railway
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
