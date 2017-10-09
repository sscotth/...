#!/bin/bash

for i in **/*.mp4; do
    ffmpeg -i "$i" -c:a libmp3lame -c:v copy -q:a 6 "${i%.*}.mp3"
done


