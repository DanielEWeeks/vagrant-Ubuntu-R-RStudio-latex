# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  # All Vagrant configuration is done here. The most common configuration
  # options are documented and commented below. For a complete reference,
  # please see the online documentation at vagrantup.com.

  # Every Vagrant virtual environment requires a box to build off of.
# config.vm.box = "puppetlabs/ubuntu-16.04-64-puppet"
  config.vm.box = "marcoaltieri/ubuntu-desktop-16.04-64bit"
  config.disksize.size = '10GB'


#  config.vm.box_url = "https://cloud-images.ubuntu.com/vagrant/trusty/current/trusty-server-cloudimg-i386-vagrant-disk1.box"

  config.vm.network :forwarded_port, host:1999, guest: 8000

  # this is needed so that puppet doesn't complain about the lack of a fqdn in our box
  config.vm.hostname = "rbox.example.com"
# config.ssh.username = "vagrant"
# config.ssh.password = "hugen2070"

  # Provider-specific configuration so you can fine-tune various
  # backing providers for Vagrant. These expose provider-specific options.
  # Example for VirtualBox:
  #
  config.vm.provider "virtualbox" do |vb|
     # Don't boot with headless mode
     vb.gui = true
     vb.name='r-box-2018'  
     # Use VBoxManage to customize the VM. For example to change memory:
     vb.memory = 2048
   end
  #
  # View the documentation for the provider you're using for more
  # information on available options.

  # Try sleeping for 30 seconds to try to avoid
  # 'Unable to lock the administration directory' errors:
$script = <<SCRIPT
  sleep 30
SCRIPT

  # remove libreoffice and thunderbird to free up disk space
 config.vm.provision :shell do |shell|
  shell.inline = "sudo apt-get remove --purge libreoffice* -y;
                  sudo apt-get remove --purge thunderbird -y;
                  sudo apt-get clean;
                  sudo apt-get autoremove -y"
end

 # Install java and jdk, as this is needed by 'iplots':
 config.vm.provision :shell do |shell|
  shell.inline = "sudo apt-get install default-jre -y;
                  sudo apt-get install default-jdk -y"
end

  # install puppetlabs/stdlib module
  config.vm.provision :shell, :inline => "sudo apt install -y puppet-common"
  config.vm.provision :shell, :inline => "mkdir -p /etc/puppet/modules && ( (puppet module list | grep puppetlabs-stdlib) || puppet module install puppetlabs/stdlib)"

# config.vm.provision :shell do |shell|
#  shell.inline = "mkdir -p /etc/puppet/modules;
#                  puppet module install puppetlabs/nodejs;
#                  puppet module install puppetlabs/apache"
#end
  
# config.vm.provision "shell", inline: "sudo apt-get update"
# config.vm.provision "shell", inline: "sudo sudo apt-get install -y --no-install-recommends ubuntu-desktop"
  # Enable provisioning with Puppet stand alone.  Puppet manifests
  # are contained in a directory path relative to this Vagrantfile.
  # You will need to create the manifests directory and a manifest in
  # the file default.pp in the manifests_path directory.
  #
  config.vm.provision "puppet" do |puppet|
#   puppet.environment = "production"
#   puppet.environment_path = "environments"
    puppet.manifests_path = "manifests"
    puppet.manifest_file  = "site.pp"
  end

 # Remove the very large texlive documentation:
 config.vm.provision :shell do |shell|
  shell.inline = "sudo apt-get remove --purge texlive-fonts-recommended-doc -y;
                  sudo apt-get remove --purge texlive-latex-base-doc -y;
                  sudo apt-get remove --purge texlive-latex-extra-doc -y;
                  sudo apt-get remove --purge texlive-latex-recommended-doc -y;
                  sudo apt-get remove --purge texlive-pictures-doc -y;
                  sudo apt-get remove --purge texlive-pstricks-doc -y;
                  sudo apt-get clean;
                  sudo apt-get autoremove -y"
end


end
