$as_vagrant   = 'sudo -u vagrant -H bash -l -c'
$home         = '/home/vagrant'

Exec {
  path => ['/usr/sbin', '/usr/bin', '/sbin', '/bin']
}

# --- Preinstall Stage ---------------------------------------------------------

stage { 'preinstall':
  before => Stage['main']
}

class apt_get_update {
  exec { 'apt-get -y update':
    unless => "test -e ${home}/.rvm"
  }
}
class { 'apt_get_update':
  stage => preinstall
}

# --- SQLite -------------------------------------------------------------------

package { ['sqlite3', 'libsqlite3-dev']:
  ensure => installed;
}

# --- Memcached ----------------------------------------------------------------

class { 'memcached': }

# --- Packages -----------------------------------------------------------------

package { 'curl':
  ensure => installed
}

package { 'build-essential':
  ensure => installed
}

package { 'git-core':
  ensure => installed
}

# Nokogiri dependencies.
package { ['libxml2', 'libxml2-dev', 'libxslt1-dev']:
  ensure => installed
}

# capybara-webkit dependencies.
package { 'libqtwebkit-dev':
  ensure => installed
}

# --- NodeJS -------------------------------------------------------------------

# include nodejs

# Set the PPA package
apt::ppa { 'ppa:chris-lea/node.js':
  before => Exec['apt-get update']
}

exec { 'apt-get update':
  command => '/usr/bin/apt-get update'
}

# Specify your  linux version (from the above link)
package { 'nodejs':
  ensure => latest,
  require => Exec["apt-get update"]
}

# # Add additional Node packages
# package { 'grunt-cli':
#   ensure   => present,
#   provider => 'npm',
#   require => Package['nodejs']
# }

# package { 'express':
#   ensure   => present,
#   provider => 'npm',
#   require => Package['nodejs']
# }

# --- Ruby ---------------------------------------------------------------------

exec { 'install_rvm':
  command => "${as_vagrant} 'curl -sSL https://get.rvm.io | bash -s stable'",
  creates => "${home}/.rvm/bin/rvm",
  require => Package['curl']
}

exec { 'install_ruby':
  # We run the rvm executable directly because the shell function assumes an
  # interactive environment, in particular to display messages or ask questions.
  # The rvm executable is more suitable for automated installs.
  #
  # use a ruby patch level known to have a binary
  command => "${as_vagrant} '${home}/.rvm/bin/rvm install ruby-2.1 --autolibs=enabled && rvm --default use 2.1'",
  creates => "${home}/.rvm/bin/ruby",
  require => Exec['install_rvm']
}

exec { "${as_vagrant} 'gem install bundler --no-rdoc --no-ri'":
  creates => "${home}/.rvm/bin/bundle",
  require => Exec['install_ruby']
}

# --- ImageMagick ---------------------------------------------------------------------

class install_imagemagick {
  package { 'imagemagick':
    ensure => installed;
  }

  package { 'libmagickwand-dev':
    ensure => installed;
  }
}
class { 'install_imagemagick': }

# --- Vim ---------------------------------------------------------------------

class install_vim {
  package { 'vim':
    ensure => installed;
  }
}
class { 'install_vim': }

# --- Redis ---------------------------------------------------------------------

class { 'redis': }

# --- MongoDB ---------------------------------------------------------------------

class {'::mongodb::globals':
  manage_package_repo => true,
}->
class {'::mongodb::server': }

# --- PHP -------------------------------------------------------------------------

include php

class { ['php::fpm', 'php::cli', 'php::extension::apc']:

}

### MYSQL ####

mysql::grant { 'wordpress':
  mysql_privileges => 'ALL',
  mysql_password   => 'wordpress',
  mysql_db         => 'wordpress',
  mysql_user       => 'wordpress',
  mysql_host       => 'localhost',
}

mysql::grant { 'wptests':
  mysql_privileges => 'ALL',
  mysql_password   => 'wptests',
  mysql_db         => 'wptests',
  mysql_user       => 'wptests',
  mysql_host       => 'localhost',
}

package { 'phpmyadmin':
  ensure  => present,
  require => Package['nginx']
}


##### NGINX

class { "nginx": }
