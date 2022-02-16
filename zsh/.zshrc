eval "$(/opt/homebrew/bin/brew shellenv)"

# Replace MacOS default BSD binaries with GNU
GNUBINS_PATH=$(find /opt/homebrew/opt -type d -follow -name gnubin -print | awk '{printf "%s:", $0}')
export PATH=$GNUBINS_PATH:$PATH
