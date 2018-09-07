#! /bin/bash

printUsage() {
  echo "Usage: $0 <mps | f2md | osm2sumo>";
  exit
}

if [[ $# < 1 ]]; then
  printUsage
fi

rm -rf omnetpp sumo

echo -n "switching to $1 environment..."

case $1 in
  "mps")
    ln -s ~/src/omnetpp-5.3/ omnetpp
    ln -s ~/src/sumo-0.32.0/ sumo
    ;;

  "f2md")
    ln -s ~/src/omnetpp-5.2/ omnetpp
    ln -s ~/src/sumo-0.30.0/ sumo
    ;;

  "osm2sumo")
    ln -s ~/src/omnetpp-5.3/ omnetpp
    ln -s ~/src/sumo-0.25.0/ sumo
    ;;

  *)
    echo "$1 is an invalid option"
    printUsage
    ;;
esac

echo "done"
