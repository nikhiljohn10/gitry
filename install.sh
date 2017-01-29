#!/bin/bash
ROOT_UID="0"
if [ "$UID" -ne "$ROOT_UID" ] ; then
	echo "You must be need sudo access to install Gitry."
	echo
	echo "Try using the command: sudo ./install.sh"
	echo
	exit 1
fi
OS=$(lsb_release -si)
ARCH=$(uname -m | sed 's/x86_//;s/i[3-6]86/32/')
VER=$(lsb_release -sr)
if [ "$OS" = "Ubuntu" -a "$ARCH" = "64" ] ; then
	echo "Gitry will be installed on your $OS $VER ${ARCH}bit."
else
	echo "Your operating system is not supported."
	exit 1
fi
echo "Installing Git"
apt-get update
apt-get install -y git
while [[ -z "$fullname" ]]
do
  read -p "Enter your name: " fullname
done
git config --global user.name "${fullname}"
while [[ -z "$email" ]]
do
  read -p "Enter your email: " email
done
git config --global user.email "${email}"
echo "Git is installed on your system."
echo "Installing OpenSSH"
apt-get install -y openssh-client
apt-get install -y openssh-server
systemctl start sshd
systemctl enable sshd
echo "SSH is installed and running on your system."
echo "Adding git user to your system"
adduser git
echo "Git user successfully added"
su $SUDO_USER -c "./configure_client.sh ${email}"	# Executing client config file
mkdir /home/git/.bin 
cp ./configure.sh /home/git/.bin/configure
chmod +x /home/git/.bin/configure
chown git:git /home/git/.bin/configure 				
su git -c '/home/git/.bin/configure' 				# Executing server config file
cat /home/$SUDO_USER/.ssh/id_rsa.pub >> /home/git/.ssh/authorized_keys # Adding public key to server
cp ./gitry /home/git/.bin/gitry
chown git:git /home/git/.bin/gitry
chmod +x /home/git/.bin/gitry
ln -s /home/git/.bin/gitry /usr/local/bin/gitry 	# Create a symbolic link to bin directory where executables exists
cp ./git /var/lib/AccountsService/users/git 		# Diable GUI login
chown root:root /var/lib/AccountsService/users/git
rm /home/git/.bin/configure 						# Removing server config file
echo "Gitry installed successfully"
echo "To clone a repo: git clone git@localhost:/home/git/repo_name.git"
echo "To add remote: git remote add origin git@localhost:/home/git/repo_name.git"
echo "To use gitry: ssh git@localhost"
echo "$ gitry [add|delete|list] REPO_NAME"
exit 0