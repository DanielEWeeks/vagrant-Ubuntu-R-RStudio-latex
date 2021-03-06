
$username = 'vagrant'

Exec { 
  path => [ "/bin/", "/sbin/" , "/usr/bin/", "/usr/sbin/","/usr/local/bin" ]
} 

# a command to run system updates
exec { 'sys_update':
  command => "apt-get update --fix-missing",
}

class git {
  package{'git-core':
    ensure => 'installed',
    require => Exec['sys_update'],
  }
}

class basic_gui{
  package{'xfce4':
    require => Exec['sys_update'],
    ensure => 'installed'       
  } ->
  package {'lightdm':
    ensure => 'installed',    
  } ->
  package {'lightdm-gtk-greeter':
    ensure => 'installed',
  } ->
  file {'/etc/lightdm/lightdm.conf':
    ensure => 'present',
    owner => 'root',
    content => "[SeatDefaults] \n greeter-session=lightdm-gtk-greeter\n",
  } ->
  service {'lightdm':
    ensure => 'running',
    enable => true,
  } 
}

class fix_broken{
  exec{'fix-broken-command':
    command => 'apt-get -f install --assume-yes',
  }
}

class chrome{
  require fix_broken
  exec{'download chrome deb':
    command => 'wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb',
    cwd => "/home/${username}",
    creates => "/home/${username}google-chrome-stable_current_amd64.deb",
  } ->
  exec{'install stuff needed for chrome':
      command =>'apt-get install libappindicator1 libdbusmenu-gtk4 libfile-desktopentry-perl libfile-mimeinfo-perl libindicator7 libxss1 xdg-utils --assume-yes',
  } ->
  exec{'install chrome':
    command => 'dpkg -i google-chrome-stable_current_amd64.deb',
    cwd => "/home/${username}",
    creates => "/usr/bin/google-chrome",
  } -> 
  exec{'add shortcuts to desktop':
    require => Class['home'],
    command => "ln -s /usr/bin/google-chrome /home/${username}/Desktop/google-chrome",
    creates => "/home/${username}/Desktop/google-chrome",
  } ->
  exec{'set permissions':
    require => Class['home'],
    command =>"chmod +x /home/${username}/Desktop/*",
    provider => 'shell',
  }
}

class install_tex {
    package { ['texlive-base', 'texlive-latex-recommended',
               'texlive-fonts-recommended', 'texlive-latex-extra' ]:
        ensure => present,
    }
}


class r_stuff{
  require fix_broken
  package{'r-base':
    require => Exec['sys_update'],
    ensure => 'installed'
  } ->
  # required for rstudio
  package{'libgstreamer-plugins-base0.10-0':
    ensure => 'installed'
  } ->
  package{'libgstreamer0.10-0':
    ensure => 'installed'
  } ->
  package{'libjpeg62':
    ensure => 'installed'
  } ->
  exec{'download rstudio':
#   command => 'wget http://download1.rstudio.org/rstudio-0.98.953-i386.deb',
    command => 'wget http://download1.rstudio.org/rstudio-0.99.903-amd64.deb',
    cwd => "/home/${username}",
    creates => "/home/${username}/rstudio-0.99.903-amd64.deb",
    user => "${username}",
  } ->
  exec{'install rstudio':
    command => 'dpkg -i rstudio-0.99.903-amd64.deb',
    creates => '/usr/bin/rstudio',
  } ->
  exec{'add shortcut':
    require => Class['home'],
    command => "ln -s /usr/bin/rstudio /home/${username}/Desktop/rstudio",
    creates => "/home/${username}/Desktop/rstudio",
  } ->
  exec{'set permissions on desktop':
    require => Class['home'],
    command =>"chmod +x /home/${username}/Desktop/rstudio",
    provider => 'shell',  
  } ->
  # these are needed for stuff like devtools
#  package{'libcurl4-gnutls-dev':
#    ensure => 'installed',
#  } ->
#  package{'libcurl4-nss-dev':
#    ensure => 'installed',
#  } ->
#  package{'libcurl4-openssl-dev':
#    ensure => 'installed'
#  } ->
#   user { 'vagrant':
#        # for R package installs, need:
#        groups   => ['vagrant', 'staff'],
#    }
#    ->
    exec {'install-r-java':
        provider => shell,
        timeout  => 3000,
        command  => 'sudo R CMD javareconf'
    } ->
    exec {'install-r-packages':
        provider => shell,
        timeout  => 3000,
        command  => 'Rscript /vagrant/r-packages.R'
    }

}

class home{
  file{"/home/${username}/Desktop":
    ensure => 'directory',
    owner => "${username}",  
  }
  file{"/home/${username}/Downloads":
    ensure => 'directory',
    owner => "${username}",  
  }
  file{"/home/${username}/Documents":
    ensure => 'directory',
    owner => "${username}",  
  }
}

include git
include fix_broken
# include chrome
# include basic_gui
include install_tex
include r_stuff
include home
