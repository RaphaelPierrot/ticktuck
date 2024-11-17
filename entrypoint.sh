#!/bin/sh

# Démarrer le backend
node /app/backend/server.js &

# Démarrer Nginx
nginx -g 'daemon off;'
