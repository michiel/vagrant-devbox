# Vagrant Devbox

This is a development machine image based on Debian 9 (stretch)

## Setup

Using this requires working installations of,

 - Vagrant
 - Virtualbox

At a minimum, edit or remove the `config.vm.synced_folder` lines in the `Vagrantfile`.

## Usage

    vagrant up
    vagrant ssh
    vagrant halt

To update a running machine,

    vagrant provision


