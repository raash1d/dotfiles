# cd into the sumo directory and these commands
make -f Makefile.cvs
./configure --with-python --with-osg --with-ffmpeg
make -j2
sudo make install
