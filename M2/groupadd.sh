#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

GROUP_NAME="devteam"
PROJECT_DIR="/opt/project_alpha"
USERS=("alice" "bob" "charlie")

# Ensure script is run with root privileges via sudo
if [ "$EUID" -ne 0 ]; then
    echo "Error: Please run this script with sudo (e.g., sudo ./myscript.sh)" >&2
    exit 1
fi

# Create group if it doesn't already exist
if ! getent group "$GROUP_NAME" > /dev/null; then
    groupadd "$GROUP_NAME"
    echo "Created group: $GROUP_NAME"
else
    echo "Group $GROUP_NAME already exists."
fi

# Create users and assign them to the group safely
for user in "${USERS[@]}"; do
    if id "$user" &>/dev/null; then
        echo "User $user already exists."
    else
        useradd -m -g "$GROUP_NAME" "$user"
        echo "Created user $user and assigned to $GROUP_NAME."
    fi
done

# Create project directory and configure permissions
mkdir -p "$PROJECT_DIR"
chown root:"$GROUP_NAME" "$PROJECT_DIR"
chmod 2770 "$PROJECT_DIR"

echo "Successfully configured project directory at $PROJECT_DIR with SGID permissions."
