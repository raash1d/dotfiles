#cd into omnetpp directory and then run these commands

cd $(pwd)
source setenv # set environment variables for omnetpp
sudo add-apt-repository ppa:ubuntugis/ppa
sudo apt update
sudo apt-get install build-essential gcc g++ bison flex perl tcl-dev tk-dev \
  blt libxml2-dev zlib1g-dev default-jre doxygen graphviz libwebkitgtk-1.0-0 \
  openmpi-bin libopenmpi-dev libpcap-dev autoconf automake libtool \
  libproj-dev libgdal1-dev libfox-1.6-dev libgdal-dev libxerces-c-dev \
  qt4-dev-tools qt5-default libqt5opengl5-dev nemiver libopenscenegraph-dev \
  libosgearth-dev openscenegraph-plugin-osgearth
./configure
make -j2
make install-desktop-icon
make install-menu-icon

