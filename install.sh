#!/bin/bash

read -p "Do you want to install SCPBackup [Y/n]? " yn
if [[ "$yn" == "n" ]]; then
    exit
fi

read -p "Choose outdir: " outdir
if [[ -z "${outdir}" ]]; then
    outdir="."
fi

outdir=$(realpath "${outdir}")
echo "${outdir}"
cd $outdir &> /dev/null || echo "Invalid output directory"

if ! command -v git &> /dev/null
then
    echo "Command git not found. Installing now."
    pkg install git
fi

git clone "https://github.com/Edgiest05/SCPBackup.git" .tmp &> /dev/null || echo "Unable to clone repository"

# TODO: Hide script file prompt
mv .tmp/scpBackup.sh .
chmod +x scpBackup.sh
rm -rf .tmp

if ! command -v crontab &> /dev/null
then
    echo "Command crontab not found. Installing now."
    pkg install cronie
fi

read -p "Insert crontab frequency: " freq
read -p "Insert source folder: " sourcedir
read -p "Insert destination folder: " destdir
if [[ ! -d "${sourcedir}" ]]; then
    echo "Invalid source directory"
    exit 1
fi
sourcedir=$(realpath "${sourcedir}")
crontab -l > .cronfile.tmp
entry="${freq} ${outdir%/}/./scpBackup.sh ${sourcedir} ${destdir}"
echo "${entry}" >> .cronfile.tmp
crontab .cronfile.tmp
rm .cronfile.tmp

if [[ -z "${SSHUSER}" ]]; then
    read -p "Insert SSHUSER new environment variable: " SSHUSER
    echo "export SSHUSER=${SSHUSER}" >> ../usr/etc/bash.bashr
fi

if [[ -z "${SSHDOMAIN}" ]]; then
    read -p "Insert SSHDOMAIN new environment variable: " SSHDOMAIN
    echo "export SSHDOMAIN=${SSHDOMAIN}" >> ../usr/etc/bash.bashr
fi

if [[ -z "${SSHPASS}" ]]; then
    read -p "Insert SSHPASS new environment variable: " SSHPASS
    echo "export SSHPASS=${SSHPASS}" >> ../usr/etc/bash.bashr
fi

echo "Autoinstall completed"
