# Removing and Disabling Snap
# Reference: https://www.baeldung.com/linux/snap-remove-disable

# Removing Existing Snap Packages
snap remove lxd
snap remove bare
snap remove core20

# Removing snapd Daemon
sudo systemctl stop snapd
sudo systemctl disable snapd
sudo systemctl mask snapd
sudo apt purge snapd -y
sudo apt-mark hold snapd

# Preventing Snap Installation Through the apt Command
rm -rf ~/snap/
sudo cat <<EOF | sudo tee /etc/apt/preferences.d/nosnap.pref
Package: snapd
Pin: release a=*
Pin-Priority: -10
EOF

# Removing Any Leftover Snap Directories
rm -rf ~/snap
sudo rm -rf /snap
sudo rm -rf /var/snap
sudo rm -rf /var/lib/snapd

# Restart systeme
echo "Reboot your machine."
