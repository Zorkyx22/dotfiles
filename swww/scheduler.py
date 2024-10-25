import os
import subprocess
from argparse import ArgumentParser
import time
import random

def absoluteFilePaths(directory):
    retour = []
    for dirpath,_,filenames in os.walk(directory):
        for f in filenames:
            retour.append(os.path.abspath(os.path.join(dirpath, f)))
    return retour

def bg_loop(folder):
    all_files = absoluteFilePaths(folder)
    random.shuffle(all_files)
    for file in all_files:
        subprocess.run(["swww","img",file, "-t", "wipe", "--transition-angle", "30"])
        time.sleep(3600)

def main(arguments):
    while True:
        bg_loop(arguments.folder)

parser = ArgumentParser("Simple python scheduler for swww wallpapers")
parser.add_argument("folder")
args = parser.parse_args()
subprocess.run(["notify-send","\"starting background switching daemon...\""])
main(args)
