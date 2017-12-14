# -*- mode: ruby -*-
# vi: set ft=ruby :

VAGRANTFILE_API_VERSION = "2"
USERNAME = 'ubuntu'
HOMEDIR = "/home/#{USERNAME}"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

  config.vm.hostname = 'proteus-dev'
  config.vm.box = "ubuntu/xenial64"


  config.vm.synced_folder "~/Downloads", "#{HOMEDIR}/Downloads", create: true
  config.vm.synced_folder "~/dev", "#{HOMEDIR}/dev", create: true
  config.vm.synced_folder "~/.cache/vagrant-apt-archives", "/var/cache/apt/archives"
  config.vm.synced_folder "~/dotfiles", "#{HOMEDIR}/dotfiles", create: true

  config.vm.network :forwarded_port, guest: 80, host: 9080

  config.vm.network :private_network, ip: "10.0.0.2"
  # config.vm.network :public_network

  config.ssh.shell = "bash -c 'BASH_ENV=/etc/profile exec bash'"
  config.ssh.forward_agent = false

  ssh_key_path = "~/.ssh/"

  config.vm.provision "shell", inline: "mkdir -p #{HOMEDIR}/.ssh"
  config.vm.provision "file", source: "#{ ssh_key_path + 'id_rsa' }", destination: "#{HOMEDIR}/.ssh/id_rsa"
  config.vm.provision "file", source: "#{ ssh_key_path + 'id_rsa.pub' }", destination: "#{HOMEDIR}/.ssh/id_rsa.pub"

  config.vm.provider :virtualbox do |vb|
    # vb.gui = true
    vb.customize ["modifyvm", :id, "--memory", "1024"]
  end

  config.vm.provision "shell", path: "config/provision.sh"

end
