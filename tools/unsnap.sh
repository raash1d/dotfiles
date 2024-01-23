# Reference: https://www.baeldung.com/linux/snap-remove-disable

snap remove lxd
snap remove bare
snap remove core20

sudo systemctl stop snapd
sudo systemctl disable snapd
sudo systemctl mask snapd

sudo apt purge snapd -y
sudo apt-mark hold snapd

rm -rf ~/snap/
sudo cat <<EOF | sudo tee /etc/apt/preferences.d/nosnap.pref
Package: snapd
Pin: release a=*
Pin-Priority: -10
EOF
rm -rf ~/snap
sudo rm -rf /snap
sudo rm -rf /var/snap
sudo rm -rf /var/lib/snapd

# restart system
