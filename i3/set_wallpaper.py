import os
import glob
import random
import subprocess

wallpapers = glob.glob("{}/dotfiles/i3/wallpapers/*.jpg".format(os.environ["HOME"]))
subprocess.run(["feh", "--bg-scale", random.choice(wallpapers)])

