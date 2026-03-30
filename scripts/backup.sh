#!/bin/bash

DATE=$(date +%Y-%m-%d_%H-%M)
BACKUP_DIR="/home/ubuntu/backups"
APP_LOG="/home/ubuntu/shopeasy.log"

mkdir -p "$BACKUP_DIR"

# Capture running container logs
docker logs shopeasy >> "$APP_LOG" 2>&1

# Copy log with timestamp
cp "$APP_LOG" "$BACKUP_DIR/app_log_$DATE.log" 2>/dev/null

# Remove backups older than 7 days
find "$BACKUP_DIR" -name "*.log" -mtime +7 -delete

echo "[$DATE] Backup done." >> "$BACKUP_DIR/cron_history.log"