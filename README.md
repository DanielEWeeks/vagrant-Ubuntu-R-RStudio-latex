# vagrant-Ubuntu-R-RStudio-latex

Vagrant files to construct an Ubuntu 16.04 virtual machine with RStudio, R, and LaTeX installed.

This was constructed based on the 'R-BOX' model available here: (https://github.com/queirozfcom/r-box).

Note that depending on how fast your Internet connection is, this installation can take an hour or more.  So start this installation when you are able to leave your computer on and connected to the Internet for several hours.

To install this Ubuntu Virtual Machine, do the following:

 - Download the current version of VirtualBox from https://www.virtualbox.org and install it.
 - Download and install the Oracle VM VirtualBox Extension Pack from https://www.virtualbox.org/wiki/Downloads
 - Download Vagrant from https://www.vagrantup.com/downloads.html and install it.  On some host machines, you may need to reboot after installing Vagrant.
 - Download this project either using git or by downloading the zip file and decompressing it on your machine.
 - Open a command line and change directories into the project folder. 
 - Issue the command `vagrant plugin install vagrant-vbguest` at the host command line.
 - Issue the command `vagrant up` at the host command line, and **wait** until the script is completely done.
 - If you encounter an error message during this, the building process might complete if you issue the command `vagrant provision` at the host command line (not within the new virtual machine).
 - Login using username/password = vagrant/vagrant

Note that the 'vagrant' user has super user privileges on the Ubuntu Virtual Machine, so you are able to use 'sudo' if needed to install software or adjust permissions.
