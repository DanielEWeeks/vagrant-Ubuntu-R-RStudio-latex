# vagrant-Ubuntu-R-RStudio-latex

Vagrant files to construct an Ubuntu 16.04 virtual machine with RStudio, R, and LaTeX installed.

This was constructed based on the 'R-BOX' model available here: (https://github.com/queirozfcom/r-box).

Note that depending on how fast your Internet connection is, this installation can take an hour or two.  So start this installation when you are able to leave your computer on and connected to the Internet for several hours.

To install this Ubuntu Virtual Machine, do the following:

 - Download VirtualBox from https://www.virtualbox.org
 - Download and install the Oracle VM VirtualBox Extension Pack from https://www.virtualbox.org/wiki/Downloads
 - Download Vagrant from https://www.vagrantup.com/downloads.html
 - Download this project
 - Open a command line and change directories into the project folder. 
 - Issue the command `vagrant plugin install vagrant-vbguest`
 - Issue the command `vagrant up` and **wait** until the script is completely done.
 - Login using username/password = vagrant/vagrant
