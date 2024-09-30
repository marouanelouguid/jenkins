#!/bin/bash

# Define variables
REMOTE_USER="debian"
REMOTE_HOST="10.10.10.10"
REMOTE_PATH="/var/www/html"  # Path where files will be uploaded on remote server
LOCAL_PATH="/path/to/your/local/files"  # Path to your local files
KEY_PATH="/path/to/your/private/key"  # Path to your SSH private key

# Test SSH Connection
echo "Testing SSH connection to $REMOTE_USER@$REMOTE_HOST"
ssh -i $KEY_PATH $REMOTE_USER@$REMOTE_HOST "echo Connection successful"

# If SSH connection is successful, proceed to upload the files
if [ $? -eq 0 ]; then
    echo "Uploading files to $REMOTE_USER@$REMOTE_HOST:$REMOTE_PATH"
    scp -i $KEY_PATH $LOCAL_PATH/* $REMOTE_USER@$REMOTE_HOST:$REMOTE_PATH

    # Execute a PHP script on the remote server
    echo "Running test001.php on the remote server"
    ssh -i $KEY_PATH $REMOTE_USER@$REMOTE_HOST "php $REMOTE_PATH/test001.php"

    # Check if PHP script executed successfully
    if [ $? -eq 0 ]; then
        echo "PHP script executed successfully"
    else
        echo "Failed to execute PHP script"
    fi
else
    echo "Failed to establish SSH connection"
fi
