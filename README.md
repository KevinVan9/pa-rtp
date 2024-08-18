# pa-rtp
PulseAudio/Pipewire RTP Script

- Old method: Creates a new null sink, redirects audio to it, creates an RTP unicast stream which is then encoded to mp3 by ffmpeg to reduce bandwidth and sent to destination
- New method: Directly transcodes raw audio from node and multicasts RTP by default

Transcoding improves bandwidth from raw audio ~1500Kb/s to desired audio bitrate at the cost of a bit of delay
