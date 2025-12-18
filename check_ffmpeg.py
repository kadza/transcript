import subprocess

try:
    out = subprocess.check_output(["ffmpeg", "-version"], stderr=subprocess.STDOUT)
    print(out.decode().splitlines()[0])
except Exception as e:
    print("FFmpeg not available:", e)