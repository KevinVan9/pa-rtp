# pa-rtp
PulseAudio RTP Script

Creates a new null sink, redirects audio to it, creates an RTP unicast stream which is then encoded to mp3 by ffmpeg to reduce bandwidth and sent to destination

Load the following module for a Pipewire setup: libpipewire-module-rtp-sink
Edit config, reload units
