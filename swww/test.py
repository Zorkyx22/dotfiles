#!/etc/profiles/per-user/sire-n1chaulas/bin/python3.13
import subprocess
import time

def test():
    for i in range(5):
        subprocess.run(["notify-send",f"inner loop {i}"])
        time.sleep(2)

def main():
    for i in range(3):
        subprocess.run(["notify-send","Going into inner loop"])
        time.sleep(0.2)
        test()
        time.sleep(3)

main()

