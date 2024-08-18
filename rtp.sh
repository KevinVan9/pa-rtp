d_ip='192.168.0.159'
port='46000'
node_name='auto_null'
verbose=false
old=false

print_usage() {
  printf "Usage: \n-d <destination-ip> \n-p <destination-port> \n-v    verbose logging\n"
}

while getopts 'd:p:n:v' flag; do
  case "${flag}" in
    d) d_ip="${OPTARG}" ;;
    p) port="${OPTARG}" ;;
    n) node_name="${OPTSARG}" ;;
    v) verbose=true ;;
    o) old=true ;;
    *) print_usage
       exit 1 ;;
  esac
done

if [ "$old" = true ]; then
    src="rtp://127.0.0.1:46000"
    fmt="s16be"
    pactl unload-module module-rtp-send
    pactl unload-module module-null-sink
    pactl load-module module-null-sink sink_name=rtp channels=2 rate=44100
    pactl load-module module-rtp-send source=$(node_name).monitor channels=2 rate=44100 format=s16be destination_ip=127.0.0.1 port=46000
    pactl set-default-sink $(node_name)
else
    src="$node_name.monitor"
    fmt="pulse"
fi

if [ "$verbose" = true ]; then
    verbose="-v debug"
else
    verbose=""
fi

ffmpeg $verbose -re -f $fmt -i $src -acodec mp3 -ab 128k -ac 2 -f rtp rtp://$d_ip:$port

exit 0;
