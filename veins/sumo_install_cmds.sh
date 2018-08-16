# cd into the sumo directory and these commands
sudo apt install libavcodec-dev libavformat-dev libavutil-dev libswscale-dev\
  libxerces-c-dev libfox-1.6-dev
make -f Makefile.cvs # for plexe-sumo only
./configure --with-python --with-osg --with-ffmpeg
make -j2
sudo make install
