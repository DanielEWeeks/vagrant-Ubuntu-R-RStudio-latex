# vagrant-Ubuntu-R-RStudio-latex

Vagrant files to construct an Ubuntu 16.04 virtual machine with RStudio, R, and LaTeX installed.

This was constructed based on the 'R-BOX' model available here: (https://github.com/queirozfcom/r-box).

Note that depending on how fast your Internet connection is, this installation can take an hour or more.  So start this installation when you are able to leave your computer on and connected to the Internet for several hours.

To install this Ubuntu Virtual Machine, do the following:

 - Download the current version of VirtualBox from https://www.virtualbox.org and install it.
 - Download the Oracle VM VirtualBox Extension Pack from https://www.virtualbox.org/wiki/Downloads and install it.  To agree to the license, you will need to scroll all the way to the bottom before the "I Agree" button will become active.
 - Download Vagrant from https://www.vagrantup.com/downloads.html and install it.  On some host machines, you may need to reboot after installing Vagrant.
 - Download this project either using git or by downloading the zip file and decompressing it on your machine.
 - Download this Vagrant plugin via `git clone https://github.com/sprotheroe/vagrant-disksize.git`.
 - Open a command line and change directories into the project folder. 
 - Issue the command `vagrant plugin install vagrant-vbguest` at the host command line.
 - Issue the command `vagrant plugin install vagrant-disksize` at the host command line.
 - Issue the command `vagrant up` at the host command line, and **wait** until the script is completely done.
 - If you encounter an error message during this, the building process might complete if you issue the command `vagrant provision` at the host command line (not within the new virtual machine).
 - Login using username/password = vagrant/vagrant

Note that the 'vagrant' user has super user privileges on the Ubuntu Virtual Machine, so you are able to use 'sudo' if needed to install software or adjust permissions.

While the Vagrant configuration file requests and creates a 10 GB disk, it actually wasn't usable until after doing the following steps:

a) Launch off a LiveCD containing Gparted
b) Deactivate the partition
c) Resize the partition
d) Then boot back into the virtual machine and do:

`sudo pvdisplay 
`sudo pvresize /dev/sda5`
`sudo lvresize -l +100%FREE /dev/mapper/ubuntu--vg-root`
`sudo resize2fs /dev/mapper/ubuntu--vg-root`

e) Reboot
