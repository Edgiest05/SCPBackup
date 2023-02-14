# SCPBackup

Custom script to backup with SCP purely in shell

This repo exist just so I can backup my pictures easily with Termux, don't expect too much from it

# Autoinstall (Termux only)
To automatically set up the script to run with [crontab](https://man7.org/linux/man-pages/man1/crontab.1.html)

    curl https://raw.githubusercontent.com/Edgiest05/SCPBackup/autoinstall/install.sh | bash

Follow the setup steps and enjoy

# Usage
The script ensures by himself that it has everything it needs, else it won't run

The syntax is:

    ./scpBackup.sh <source folder> <destination folder>

In addition, it will search for environment variables:
* SSHUSER
* SSHDOMAIN
* SSHPASS

The script won't ask for any kind of input, hence can be used as script for crontab or similar

At the moment everything in the source folder will be tranferred, subfolders included

**THE SOFTWARE WILL WIPE THE ENTIRE SPECIFIED FOLDER CONTENTS IF IT SUCCEEDS**
