#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

# Restore the database if it does not already exist.
if [ -f /root/app/pb_data/data.db ]; then
  echo "Database already exists, skipping restore"
else
  echo "No database found, restoring from replica if exists"
  litestream restore -if-replica-exists /root/app/pb_data/data.db
fi

# Run litestream with your app as the subprocess.
# Use port 8080 for deploying to Fly.io, GCP Cloud Run, or AWS App Runner easily.
exec litestream replicate -exec "/root/app/server serve --http=0.0.0.0:8080"