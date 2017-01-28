# Gitry
A bash program to deploy git server for Ubuntu based operating systems of 64bit arch.

### Installation

Simply run the following commands
```
sudo apt-get install -y wget
wget https://github.com/nikhiljohn10/gitry/archive/master.zip -O temp.zip
unzip temp.zip && rm temp.zip
cd gitry-master && sudo ./install.sh
```

### Usage

To access gitry, ssh in to localhost using following command
```
$ ssh git@localhost # the install.sh adds pubic key of your system to server, hence no password needed
```

To use gitry after logging in 
```
$ gitry list # list all the git repos added to server
$ gitry add <repositry> # add a new repo in to server (do not use .git in repo name)
$ gitry delete <repositry> # delete a repo from server (do not use .git in repo name)

```

### Possibles errors

This is hardcorded for Ubuntu 16.04 LTS 64bit desktop version. The dependancies and commands may vary on your distribution. Please check all the commands in the script before running. The script is not tested much. So, report issue in repo to solve them.


### Future

Planning to do and local git framework using either Node / Django on top of this script to give user a web based GUI and accomedate multiple user when it is deloyed on a server. Contact me if interested in working on it. 

Cheers!
