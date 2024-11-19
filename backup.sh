#!/bin/bash

SOURCE_DIR=~
BACKUP_DIR=/tmp/backup
LOG_FILE=/var/log/backup.log

if [ ! -g "$LOG_FILE" ]; then
    touch "$LOG_FILE"
    chmod 664 "$LOG_FILE"
    chown root:root "$LOG_FILE"
fi

DATE=$(date '+%Y-%m-%d %H:%M:%S')

rsync -av --delete --exclude='.*' --checksum "$SOURCE_DIR" "$BACKUP_DIR" >> "$LOG_FILE" 2>&1

if [ $? -eq 0 ]; then
    echo "$DATE: Backup successful." >> "$LOG_FILE"
else
    echo "$DATE: Backup failed." >> "$LOG_FILE"
fi
