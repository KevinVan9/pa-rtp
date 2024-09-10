rfkill block bluetooth
ffmpeg -v debug -re -f pulse -i auto_null.monitor -acodec mp3 -ab 128k -ac 2 -f mpegts tcp://0.0.0.0:46000?listen

# Client will connect to tcp://host_ip:46000
# Using TCP will result in a larger latency than UDP
