#cd into omnetpp directory and then run these commands

cd $(pwd)
source setenv # set environment variables for omnetpp
sudo add-apt-repository ppa:ubuntugis/ppa
sudo apt update
sudo apt-get install build-essential gcc g++ bison flex perl \
     qt5-default libqt5opengl5-dev tcl-dev tk-dev libxml2-dev \
     zlib1g-dev default-jre doxygen graphviz libwebkitgtk-1.0 nemiver \
     libopenscenegraph-dev libosgearth-dev openscenegraph-plugin-osgearth \
     openmpi-bin libopenmpi-dev
./configure
make -j2
make install-desktop-icon
make install-menu-icon

