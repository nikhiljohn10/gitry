#!/bin/bash
echo "Generating SSH Key on git client"
ssh-keygen -t rsa -b 4096 -C "$1"
eval "$(ssh-agent -s)"
cd && ssh-add .ssh/id_rsa
exit 0