#!/bin/bash
# Provisioning file for Vagrant
# Install the software


set -e

export LC_ALL=C 
export DEBIAN_FRONTEND=noninteractive

sudo adduser vagrant sudo

apt-get -y update
apt-get install -y software-properties-common

# Install KDE

apt-get install -y kubuntu-desktop
apt-get remove -y libreoffice-common



# Deps for master (Py3/Qt5)
add-apt-repository ppa:ubuntugis/ubuntugis-unstable -y
apt-get -y update

apt-get install -y git cmake flex bison libproj-dev libgeos-dev libgdal1-dev \
libexpat1-dev libfcgi-dev libgsl0-dev libpq-dev libqca2-dev libqca2-plugin-ossl \
pyqt5-dev qttools5-dev qtpositioning5-dev libqt5svg5-dev libqt5webkit5-dev \
python3-pyqt5.qtwebkit python3-pyqt5.qtsvg qt5keychain-dev \
libqt5gui5 libqt5scripttools5 qtscript5-dev libqca-qt5-2-dev grass grass-dev \
libgeos-dev libgdal-dev libqt5xmlpatterns5-dev libqt5scintilla2-dev python3-gdal python3-yaml \
pyqt5.qsci-dev python3-pyqt5.qsci libgsl-dev txt2tags libproj-dev libqwt-qt5-dev \
libspatialindex-dev pyqt5-dev-tools qttools5-dev-tools qt5-default python3-future \
python3-pyqt5.qtsql python3-psycopg2 python3-pygments lighttpd locales pkg-config poppler-utils python3-dev \
python3-pyqt5 pyqt5.qsci-dev python3-pyqt5.qtsql spawn-fcgi xauth xfonts-100dpi \
xfonts-75dpi xfonts-base xfonts-scalable xvfb vim supervisor expect python3-setuptools \
python3-dev python3-owslib libzip-dev p7zip-full ccache


chmod -R a+w /usr/lib/x86_64-linux-gnu/qt5/plugins/designer/
chmod -R a+w /usr/lib/python3/dist-packages/PyQt5/uic/widget-plugins/

# Ccache
ln -s /usr/bin/ccache  /usr/local/bin/g++
ln -s /usr/bin/ccache  /usr/local/bin/gcc

# Install Qt Creator

pushd .
cd /usr/local
wget http://download.qt.io/official_releases/qtcreator/4.5/4.5.1/installer_source/linux_gcc_64_rhel72/qtcreator.7z
7za x qtcreator.7z
rm qtcreator.7z
popd

# Clean
apt-get autoremove -y
apt clean

# Git clone QGIS
cd /home/vagrant
git clone https://github.com/qgis/QGIS.git
mkdir /home/vagrant/QGIS/build-local
cp /vagrant/CMakeCache.txt /home/vagrant/QGIS/build-local
chown -R vagrant.vagrant /home/vagrant/QGIS

