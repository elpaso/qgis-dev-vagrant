# -*- mode: ruby -*-
# vi: set ft=ruby :

BOX = "Kynda/kubuntu-bionic64"

Vagrant.configure("2") do |config|
  config.vm.box = BOX
  config.vm.box_version = "0.1.0"

  config.vm.provider "virtualbox" do |v|
    v.gui = true
    v.memory = 8192
    v.cpus = 3
    v.customize ["modifyvm", :id, "--vram", "128"]
    v.customize ["modifyvm", :id, "--usb", "on"]
    v.customize ["modifyvm", :id, "--usbehci", "off"]
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
