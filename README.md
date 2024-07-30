# pa-rtp
PulseAudio RTP Script

Creates a new null sink, redirects audio to it, creates an RTP unicast stream which is then encoded to mp3 by ffmpeg to reduce bandwidth and sent to destination

A problem I encountered was ffmpeg/vlc being unable to decode the RTP stream properly, complaining that an SDP file was needed. I could only fix it by nuking the audio install. Might have been something with the Pipewire/PulseAudio service and/or configuration.

Load the following module for a Pipewire setup: libpipewire-module-rtp-sink
Edit config, reload units
