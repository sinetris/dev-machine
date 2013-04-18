# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrant dev-machine from:
# https://github.com/sinetris/dev-machine

Vagrant::Config.run do |config|
  config.vm.box       = 'precise64'
  config.vm.box_url   = 'http://files.vagrantup.com/precise64.box'
  config.vm.host_name = 'dev-machine'
  # config.vm.network :hostonly, "192.168.10.102"

  config.vm.forward_port 3000, 3000

  config.vm.provision :puppet do |puppet|
    puppet.manifests_path = "puppet/manifests"
    puppet.module_path    = "puppet/modules"
    puppet.manifest_file  = "default.pp"
  end
end
