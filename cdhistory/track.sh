#!/bin/bash
# Source this file to enable cdhistory tracking
# Add to ~/.bashrc or ~/.zshrc: source /path/to/cdhistory/track.sh

CDHISTORY_FILE="${CDHISTORY_FILE:-$HOME/.cdhistory}"

_cdhistory_track() {
    local dir="$PWD"
    [[ -z "$dir" || ! -d "$dir" ]] && return
    
    # Create histfile if needed
    touch "$CDHISTORY_FILE"
    
    # Don't add if same as last entry
    local last_dir
    last_dir=$(head -n1 "$CDHISTORY_FILE" 2>/dev/null)
    [[ "$dir" == "$last_dir" ]] && return
    
    # Remove if exists elsewhere, add at top
    local tmpfile
    tmpfile=$(mktemp)
    grep -v "^${dir}$" "$CDHISTORY_FILE" > "$tmpfile" 2>/dev/null
    echo "$dir" >> "$tmpfile"
    
    # Keep only last 20
    tail -n 20 "$tmpfile" > "$CDHISTORY_FILE"
    rm -f "$tmpfile"
}

# Hook into cd
cd() {
    builtin cd "$@" || return
    _cdhistory_track
}

# Track current directory on source
_cdhistory_track

echo "cdhistory enabled. Use 'cdhistory -l' to list, 'cdhistory' to go back."
