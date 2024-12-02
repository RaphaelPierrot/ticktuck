# Étape 1: Build de l'application Flutter
FROM ubuntu:20.04 AS flutter-build

ENV DEBIAN_FRONTEND=noninteractive

# Installer les dépendances nécessaires
RUN apt-get update && apt-get install -y \
    curl git wget unzip libgconf-2-4 gdb libstdc++6 libglu1-mesa fonts-droid-fallback python3 && \
    apt-get clean

# Télécharger et installer la dernière version stable de Flutter
RUN git clone https://github.com/flutter/flutter.git /usr/local/flutter

ENV PATH "$PATH:/home/developer/flutter/bin"
RUN flutter doctor
# Mettre à jour Flutter pour obtenir la dernière version stable
RUN flutter channel stable
RUN flutter upgrade
RUN flutter config --enable-web

# Vérifier les versions installées
RUN flutter --version
RUN dart --version

WORKDIR /app

# Copier les fichiers du projet et installer les dépendances
COPY pubspec.* ./
RUN flutter pub get
COPY . .
RUN flutter build web --dart-define=BASE_URL=https://ticktuck-production.up.railway.app

# Étape 2: Serveur Nginx
FROM nginx:stable-alpine AS production

WORKDIR /usr/share/nginx/html

# Copier le build Flutter
COPY --from=flutter-build /app/build/web/ .

# Configurer Nginx
COPY ./nginx.conf /etc/nginx/conf.d/default.conf

EXPOSE 80

# CMD pour lancer Nginx et le backend avec un script d'entrée
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

CMD ["/entrypoint.sh"]
