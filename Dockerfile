# Utilisez une image Dart compatible avec votre SDK
FROM dart:3.2.2 AS build

# Reste du Dockerfile
WORKDIR /app
COPY pubspec.* ./
RUN dart pub get

COPY . .
RUN dart compile exe bin/main.dart -o /app/tiktuck

# Phase de runtime
FROM scratch
COPY --from=build /runtime/ /
COPY --from=build /app/tiktuck /app/tiktuck
ENTRYPOINT ["/app/tiktuck"]
