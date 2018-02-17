#!/bin/bash
# Install Guest additions
sudo apt-get install -y linux-headers-$(uname -r) build-essential dkms

wget http://download.virtualbox.org/virtualbox/5.0.40/VBoxGuestAdditions_5.0.40.iso
sudo mkdir /media/VBoxGuestAdditions
sudo mount -o loop,ro VBoxGuestAdditions_5.0.40.iso /media/VBoxGuestAdditions
sudo sh /media/VBoxGuestAdditions/VBoxLinuxAdditions.run
rm VBoxGuestAdditions_5.0.40.iso
sudo umount /media/VBoxGuestAdditions
sudo rmdir /media/VBoxGuestAdditions