# Étape 1: Build de l'application Flutter
FROM ubuntu:20.04 AS flutter-build

ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update && apt-get install -y \
    curl git wget unzip libgconf-2-4 gdb libstdc++6 libglu1-mesa fonts-droid-fallback python3 && \
    apt-get clean

# Configurer les variables d'environnement Flutter
ENV PUB_HOSTED_URL=https://pub.flutter-io.cn
ENV FLUTTER_STORAGE_BASE_URL=https://storage.flutter-io.cn

# Télécharger Flutter SDK
RUN git clone https://github.com/flutter/flutter.git /usr/local/flutter
ENV PATH="/usr/local/flutter/bin:/usr/local/flutter/bin/cache/dart-sdk/bin:${PATH}"

# Initialiser Flutter
RUN flutter doctor
RUN flutter channel stable
RUN flutter upgrade
RUN flutter config --enable-web

WORKDIR /app
COPY pubspec.* ./
RUN flutter pub get
COPY . .
RUN flutter build web --dart-define=BASE_URL=https://ticktuck-production.up.railway.app


# Étape 2: Configuration du back-end Node.js
FROM node:18-alpine AS backend-build

WORKDIR /app
COPY tiktuck-backend/package*.json ./tiktuck-backend/
RUN cd tiktuck-backend && npm install
COPY tiktuck-backend ./tiktuck-backend

# Étape 3: Serveur final combiné avec Nginx et backend Node.js
FROM nginx:stable-alpine AS production

# Configurer le répertoire Nginx
WORKDIR /usr/share/nginx/html

# Copier les fichiers front-end de l'étape Flutter
COPY --from=flutter-build /app/build/web/ .

# Copier le backend dans un sous-dossier
COPY --from=backend-build /app/tiktuck-backend /app/backend

# Configurer Nginx pour servir le front-end et proxy API vers le backend
COPY ./nginx.conf /etc/nginx/conf.d/default.conf

# Exposer les ports pour Nginx et le backend
EXPOSE 80 3000

# CMD pour lancer Nginx et le backend avec un script d'entrée
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

CMD ["/entrypoint.sh"]
