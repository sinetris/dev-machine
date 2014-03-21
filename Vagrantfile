# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrant dev-machine from:
# https://github.com/sinetris/dev-machine

Vagrant.configure("2") do |config|
  # need "vagrant plugin install vagrant-vbguest"
  # config.vbguest.installer = "CloudUbuntuVagrant"
  # config.vm.box       = 'saucy64'
  # config.vm.box_url   = 'http://cloud-images.ubuntu.com/vagrant/saucy/current/saucy-server-cloudimg-amd64-vagrant-disk1.box'
  config.vm.box       = 'precise64'
  config.vm.box_url   = 'http://files.vagrantup.com/precise64.box'
  config.vm.host_name = 'dev-machine'
  # config.vm.share_folder "v-data", "/vagrant", ".", owner: 'vagrant', group: 'vagrant'
  # config.vm.network :hostonly, "192.168.10.102"

  config.vm.network "forwarded_port", guest: 3000, host: 3000

  config.vm.provision :puppet do |puppet|
    puppet.manifests_path = "puppet/manifests"
    puppet.module_path    = "puppet/modules"
    puppet.manifest_file  = "default.pp"
  end
end
