#!/bin/bash
# Provisioning file for Vagrant
# Install the software


set -e

export LC_ALL=C
export DEBIAN_FRONTEND=noninteractive

sudo adduser vagrant sudo

if [ -e /etc/apt/apt.conf.d/20auto-upgrades ]; then
    sed -i -e 's/"1"/"0"/g' /etc/apt/apt.conf.d/20auto-upgrades
fi


systemctl stop apt-daily.service
systemctl kill --kill-who=all apt-daily.service

killall apt || true
killall apt-get || true

apt-get -y update
apt-get install -y software-properties-common

# Install KDE and other requirements
apt-get install -y kubuntu-desktop  p7zip-full git
apt-get remove -y libreoffice-common

# Deps for master (Py3/Qt5)
add-apt-repository ppa:ubuntugis/ubuntugis-unstable -y

apt-get -y update

# QGIS build deps
apt-get install -y \
    bison ca-certificates ccache cmake cmake-curses-gui dh-python doxygen expect flex flip gdal-bin git graphviz grass-dev libexiv2-dev libexpat1-dev libfcgi-dev libgdal-dev libgeos-dev libgsl-dev libpdal-dev libpq-dev libproj-dev libprotobuf-dev libqca-qt5-2-dev libqca-qt5-2-plugins libqscintilla2-qt5-dev libqt5opengl5-dev libqt5serialport5-dev libqt5sql5-sqlite libqt5svg5-dev libqt5webkit5-dev libqt5xmlpatterns5-dev libqwt-qt5-dev libspatialindex-dev libspatialite-dev libsqlite3-dev libsqlite3-mod-spatialite libyaml-tiny-perl libzip-dev libzstd-dev lighttpd locales ninja-build ocl-icd-opencl-dev opencl-headers pandoc pdal pkg-config poppler-utils protobuf-compiler pyqt5-dev pyqt5-dev-tools pyqt5.qsci-dev python3-all-dev python3-autopep8 python3-dateutil python3-dev python3-future python3-gdal python3-httplib2 python3-jinja2 python3-lxml python3-markupsafe python3-mock python3-nose2 python3-owslib python3-plotly python3-psycopg2 python3-pygments python3-pyproj python3-pyqt5 python3-pyqt5.qsci python3-pyqt5.qtpositioning python3-pyqt5.qtsql python3-pyqt5.qtsvg python3-pyqt5.qtwebkit python3-requests python3-sip python3-sip-dev python3-termcolor python3-tz python3-yaml qt3d-assimpsceneimport-plugin qt3d-defaultgeometryloader-plugin qt3d-gltfsceneio-plugin qt3d-scene2d-plugin qt3d5-dev qt5-default qt5keychain-dev qtbase5-dev qtbase5-private-dev qtpositioning5-dev qttools5-dev qttools5-dev-tools spawn-fcgi xauth xfonts-100dpi xfonts-75dpi xfonts-base xfonts-scalable xvfb


chmod -R a+w /usr/lib/x86_64-linux-gnu/qt5/plugins/designer/
chmod -R a+w /usr/lib/python3/dist-packages/PyQt5/uic/widget-plugins/

# Ccache
ln -s /usr/bin/ccache  /usr/local/bin/g++ || true
ln -s /usr/bin/ccache  /usr/local/bin/gcc || true

# Install Qt Creator
if [[ ! -f "/usr/local/bin/qtcreator" ]]; then
    pushd .
    cd /usr/local
    wget https://download.qt.io/official_releases/qtcreator/9.0/9.0.0/installer_source/linux_x64/qtcreator.7z
    7z x qtcreator.7z
    rm qtcreator.7z
    popd
fi

# Clean
apt-get autoremove -y
apt-get clean

# Git (shallow) clone QGIS
if [[ ! -d "/home/vagrant/QGIS" ]]; then
    cd /home/vagrant
    git clone --depth=1 https://github.com/qgis/QGIS.git
    mkdir /home/vagrant/build-QGIS-Desktop-Debug
    chown -R vagrant.vagrant /home/vagrant
fi

# Enable multi user
systemctl set-default multi-user
systemctl set-default graphical

