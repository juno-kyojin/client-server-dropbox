#!/bin/bash

# Set the source and destination paths for client1 and client2
client1_path="/home/tuitachi/client-server-dropbox/client1"
client2_path="/home/tuitachi/client-server-dropbox/client2"
server_path="/home/tuitachi/client-server-dropbox/server"
tmp_path="/home/tuitachi/client-server-dropbox/tmp"

# Function to sync changes from clients to the server
sync_clients_to_server() {
    local client_path="$1"
    local file_path="$2"
    local file_name="$(basename "$file_path")"
    local tmp_file="$tmp_path/$file_name"

    # Copy the changed file to a temporary directory
    cp "$file_path" "$tmp_file"

    # Send the file to the server
    rsync -av "$tmp_file" "$server_path"

    # Clean up the temporary file
    rm "$tmp_file"
}

# Function to sync changes from the server to clients
sync_server_to_clients() {
    local file_path="$1"
    local file_name="$(basename "$file_path")"
    local tmp_file1="$tmp_path/$file_name.client1"
    local tmp_file2="$tmp_path/$file_name.client2"

    # Send the file from the server to client1
    rsync -av "$file_path" "$client1_path"
    rsync -av "$file_path" "$tmp_file1"

    # Send the file from the server to client2
    rsync -av "$file_path" "$client2_path"
    rsync -av "$file_path" "$tmp_file2"

    # Sync changes from client2 to server
    if [[ "$client_path" == "$client2_path" ]]; then
        # Send the file from client2 to the server
        rsync -av "$file_path" "$server_path"
        rsync -av "$file_path" "$tmp_file1"
    fi

    # Sync changes from client1 to server
    if [[ "$client_path" == "$client1_path" ]]; then
        # Send the file from client1 to the server
        rsync -av "$file_path" "$server_path"
        rsync -av "$file_path" "$tmp_file2"
    fi

    # Clean up temporary files
    rm "$tmp_file1" "$tmp_file2"
}

# Monitor changes on client1 and client2
while true; do
    inotifywait -r -e create,modify,delete "$client1_path" "$client2_path" |
    while read -r directory event file; do
        file_path="$directory$file"

        # Sync changes from clients to the server
        sync_clients_to_server "$directory" "$file_path"

        # Sync changes from the server to clients
        sync_server_to_clients "$file_path"
    done
done
