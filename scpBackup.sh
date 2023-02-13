#!/bin/bash

function decho () {
    echo "[`date`] $1"
}

# * Parameters check
if [[ "$1" == "" ]]; then
    decho "Needs folder as argument"
    exit 1
fi

# * Environment variables checking
if [[ -z "${SSHUSER}" ]]; then
    decho "SSHUSER env variable not set"
    exit 1
fi

if [[ -z "${SSHDOMAIN}" ]]; then
    decho "SSHDOMAIN env variable not set"
    exit 1
fi

if [[ -z "${SSHPASS}" ]]; then
    decho "SSHPASS env variable not set"
    exit 1
fi

# * Folder checking
if [[ ! -d "$1" ]]; then
    decho '"$1" is not a directory'
    exit 1
fi

if [[ -z "$(ls -A $1)" ]]; then
    decho "No files to backup. Closing..."
    exit
fi

if [[ "$2" == "" ]]; then
    decho "Destination folder is required"
    exit 1
fi

# * Start backup
# Check if command exists: https://stackoverflow.com/questions/592620/how-can-i-check-if-a-program-exists-from-a-bash-script
if ! command -v sshpass &> /dev/null
then
    decho "Command sshpass not installed"
    exit 1
fi

sshpass -e scp -r "${1%/}/." "$SSHUSER@$SSHDOMAIN:$2"
# Bash script in Termux won't delete folder contents otherwise
rm -rf "${1%/}/"
mkdir "${1%/}/"

decho "Backup completed successfully"