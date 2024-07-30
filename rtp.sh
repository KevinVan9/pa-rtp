d_ip='192.168.0.45'
port='46000'
verbose=false
log=false

print_usage() {
  printf "Usage: -d <destination-ip> -p <destination-port>"
}

while getopts 'd:p:vl' flag; do
  case "${flag}" in
    d) d_flag="${OPTARG}" ;;
    f) p_flag="${OPTARG}" ;;
    v) verbose=true ;;
    l) log=true ;;
    *) print_usage
       exit 1 ;;
  esac
done


pactl unload-module module-rtp-send
pactl unload-module module-null-sink
pactl load-module module-null-sink sink_name=rtp channels=2 rate=44100
pactl load-module module-rtp-send source=rtp.monitor channels=2 rate=44100 format=s16be destination_ip=127.0.0.1 port=46000
pactl set-default-sink rtp

if [ $log = true ]; then
    if [ $verbose = true ]; then
        ffmpeg -v debug -re -i rtp://127.0.0.1:46000 -acodec mp3 -ab 128k -ac 2 -f rtp rtp://$d_ip:$port 2>&1 | tee debug.log
    else
        ffmpeg -re -i rtp://127.0.0.1:46000 -acodec mp3 -ab 128k -ac 2 -f rtp rtp://$d_ip:$port 2>&1 | tee debug.log
    fi
else
    if [ $verbose = true ]; then
        ffmpeg -v debug -re -i rtp://127.0.0.1:46000 -acodec mp3 -ab 128k -ac 2 -f rtp rtp://$d_ip:$port
    else
        ffmpeg -re -i rtp://127.0.0.1:46000 -acodec mp3 -ab 128k -ac 2 -f rtp rtp://$d_ip:$port
    fi
fi



