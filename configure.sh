#!/bin/bash
echo "Generating SSH Key on git server"
while [[ -z "$email" ]]
do
  read -p "Enter server admin email: " email
done
ssh-keygen -t rsa -b 4096 -C "${email}"
eval "$(ssh-agent -s)"
cd && ssh-add .ssh/id_rsa
touch .ssh/authorized_keys && chmod 600 .ssh/authorized_keys
exit 0