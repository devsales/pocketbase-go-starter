#!/bin/bash
set -e

# Restore the database if it does not already exist.
# Use the directory our binary is in `/usr/local/bin/` to properly replicate
# and restore with PocketBase's default locaiton for the database.
if [ -f /root/app/pb_data/data.db ]; then
  echo "Database already exists, skipping restore"
else
  echo "No database found, restoring from replica if exists"
  litestream restore -if-replica-exists /root/app/pb_data/data.db
fi

# Run litestream with your app as the subprocess.
# Use port 8080 for deploying to Fly.io, GCP Cloud Run, or AWS App Runner easily.
exec litestream replicate -exec "/root/app/server serve --http=0.0.0.0:8080"