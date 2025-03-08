#!/bin/bash

# Ask for the YouTube URL
read -p "Enter the YouTube URL: " URL

# If no URL is provided, exit the script
if [ -z "$URL" ]; then
    echo "No URL provided. Exiting..."
    exit 1
fi

# Use yt-dlp to get the video title and sanitize it to create a folder name
VIDEO_TITLE=$(yt-dlp -e "$URL" | sed 's/[^a-zA-Z0-9]/_/g')

# Create the folder with the video title
mkdir -p "$VIDEO_TITLE"

# Download the video and audio (best video + best audio)
yt-dlp -f bestvideo+bestaudio --write-thumbnail --output "$VIDEO_TITLE/%(title)s.%(ext)s" "$URL"

# Download the audio as MP3
yt-dlp -f bestaudio --extract-audio --audio-format mp3 --output "$VIDEO_TITLE/%(title)s.%(ext)s" "$URL"

# Move thumbnail to the folder (yt-dlp saves it as default name, let's move it to 'thumbnail.jpg')
mv *.jpg "$VIDEO_TITLE/thumbnail.jpg" 2>/dev/null

echo "Download complete! Video, audio (MP3), and thumbnail are saved in the '$VIDEO_TITLE' folder."
