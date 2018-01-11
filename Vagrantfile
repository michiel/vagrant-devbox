# -*- mode: ruby -*-
# vi: set ft=ruby :

VAGRANTFILE_API_VERSION = "2"
USERNAME = 'vagrant'
HOMEDIR = "/home/#{USERNAME}"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

  config.vm.hostname = 'devbox'
  config.vm.box = "debian/contrib-stretch64"

  config.vm.synced_folder "~/.vim", "#{HOMEDIR}/.vim", create: true
  config.vm.synced_folder "~/Downloads", "#{HOMEDIR}/Downloads", create: true
  config.vm.synced_folder "~/dev", "#{HOMEDIR}/dev", create: true
  config.vm.synced_folder "~/.cache/vagrant-apt-archives", "/var/cache/apt/archives"

  config.vm.network :forwarded_port, guest: 80, host: 9080
  config.vm.network :private_network, ip: "10.0.0.2"

  config.ssh.forward_agent = false

  config.vm.provision "file", source: "config/_vimrc", destination: "#{HOMEDIR}/.vimrc"

  # Use the host SSH keys

  ssh_key_path = "~/.ssh/"

  config.vm.provision "shell", inline: "mkdir -p #{HOMEDIR}/.ssh"
  config.vm.provision "file", source: "#{ ssh_key_path + 'id_rsa' }", destination: "#{HOMEDIR}/.ssh/id_rsa"
  config.vm.provision "file", source: "#{ ssh_key_path + 'id_rsa.pub' }", destination: "#{HOMEDIR}/.ssh/id_rsa.pub"

  config.vm.provider :virtualbox do |vb|
    # vb.gui = true
    vb.name = "devbox"
    vb.customize ["modifyvm", :id, "--memory", "4096"]
    vb.customize ["modifyvm", :id, "--cpus", "2"]
    vb.customize ["modifyvm", :id, "--cpuexecutioncap", "70"]
  end

  config.vm.provision "shell", path: "config/provision.sh"
end

