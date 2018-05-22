cd into omnetpp directory and then run these commands

. ./setenv # set environment variables for omnetpp
sudo apt-get install build-essential gcc g++ bison flex perl \\
     qt5-default tcl-dev tk-dev libxml2-dev zlib1g-dev default-jre \\
     doxygen graphviz libwebkitgtk-3.0-0 nemiver \\
     libopenscenegraph-dev libosgearth-dev libosgearth3 \\
     libosgearthutil3 openscenegraph-plugin-osgearth
./configure
make -j2
sudo make install

