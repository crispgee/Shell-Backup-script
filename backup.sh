#!/bin/bash
SOURCE_FOLDER="/home/vboxuser/my-nest-app"
BACKUP_DIR="/home/vboxuser/Desktop"
TIMESTAMP=$(date +"%Y%m%d-%H%M%S")
BACKUP_FILENAME="backup_$(basename "$SOURCE_FOLDER")_$TIMESTAMP.zip"
mkdir -p "$BACKUP_DIR"
if [! -d "$SOURCE_FOLDER"]; then
   echo "Error : Source folder'$SOURCE_FOLDER' does not exist!"
   exit 1
fi 
if [-z "$(ls -A "$SOURCE_FOLDER" 2>/dev/null)" ]; then
   echo "Warning: Source Folder'$SOURCE_FOLDER' is empty"
fi
cd "$(dirname "$SOURCE_FOLDER")" || exit 1
zip -r "$BACKUP_DIR/$BACKUP_FILENAME" "$(basename "$SOURCE_FOLDER")" -x "*/node_modules/*" "*/.*" "*/.git/*"
if [ $? -eq 0 ]; then 
   echo "Backup of '$SOURCE_FOLDER' created at '$BACKUP_DIR/$BACKUP_FILENAME' "
else 
   echo "Backup failed"
   exit 1
fi
