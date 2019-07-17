#/usr/bin/python3

import os
import time

if __name__ == "__main__":
    os.system("python3 wea.py")
    time.sleep(5)
    os.system("python3 tts.py")
    os.system("sudo ./result.mp3")