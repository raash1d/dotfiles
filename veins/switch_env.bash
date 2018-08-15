#! /bin/bash

printUsage() {
  echo "Usage: switch_environment.sh <mps | f2md>";
}

if [[ $# < 1 ]]; then
  printUsage
  exit
fi

rm -rf omnetpp sumo

if [[ $1 == "mps" ]]; then
  echo -n "switching to mps environment..."
  ln -s ~/src/omnetpp-5.3/ omnetpp
  ln -s ~/src/sumo-0.32.0/ sumo
  echo "done"
elif [[ $1 == "f2md" ]]; then
  echo -n "switching to f2md environment..."
  ln -s ~/src/omnetpp-5.2/ omnetpp
  ln -s ~/src/sumo-0.30.0/ sumo
  echo "done"
else
  echo "Invalid option"
  printUsage
fi
