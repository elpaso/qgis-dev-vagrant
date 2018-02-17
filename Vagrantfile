# -*- mode: ruby -*-
# vi: set ft=ruby :

BOX = "xenial-canonical-64"
BOX_URL = "https://cloud-images.ubuntu.com/xenial/current/xenial-server-cloudimg-amd64-vagrant.box"


Vagrant.configure("2") do |config|
  config.vm.box = BOX
  config.vm.box_url = BOX_URL
  config.disksize.size = '20GB'

  config.vm.provider "virtualbox" do |v|
    v.gui = true
    v.memory = 8192
    v.cpus = 3
    v.customize ["modifyvm", :id, "--vram", "128"]
  end

  # Install the required software
  config.vm.provision "shell",
    path: "provision_setup.sh"

  # Run every time the VM starts
  config.vm.provision "shell",
    path: "provision_job.sh",
    args: ENV['SHELL_ARGS'],
    run: "always"

end
