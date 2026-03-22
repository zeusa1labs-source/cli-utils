#!/bin/bash
# cdhistory - Track and navigate directory history
# Usage: cdhistory [n]     - Jump to nth previous directory
#        cdhistory -l      - List history
#        cdhistory -c      - Clear history
#        cdhistory -h      - Show help

HISTFILE="${CDHISTORY_FILE:-$HOME/.cdhistory}"
MAX_HISTORY=20

show_help() {
    cat << EOF
cdhistory - Navigate directory history

Usage: cdhistory [options] [n]

Options:
    -l, --list    List directory history
    -c, --clear   Clear directory history
    -h, --help    Show this help message

Arguments:
    n             Jump to nth previous directory (0 = current, 1 = last, etc.)

Examples:
    cdhistory          # Go to previous directory
    cdhistory 1        # Same as above
    cdhistory 2        # Go back 2 directories
    cdhistory -l       # List history
    cdhistory -c       # Clear history

EOF
}

list_history() {
    if [[ ! -f "$HISTFILE" ]]; then
        echo "No directory history."
        return
    fi
    
    local count=0
    while IFS= read -r dir; do
        if [[ -n "$dir" && -d "$dir" ]]; then
            ((count++))
            if [[ $count -eq 1 ]]; then
                echo "$count: $dir (current)"
            else
                echo "$count: $dir"
            fi
        fi
    done < "$HISTFILE"
    
    if [[ $count -eq 0 ]]; then
        echo "No valid directories in history."
    fi
}

clear_history() {
    > "$HISTFILE"
    echo "Directory history cleared."
}

add_to_history() {
    local dir="$1"
    [[ -z "$dir" || ! -d "$dir" ]] && return
    
    # Create temp file without current dir
    local tmpfile
    tmpfile=$(mktemp)
    if [[ -f "$HISTFILE" ]]; then
        grep -v "^${dir}$" "$HISTFILE" > "$tmpfile"
    fi
    
    # Add current dir at top
    echo "$dir" >> "$tmpfile"
    
    # Trim to max history
    tail -n "$MAX_HISTORY" "$tmpfile" > "$HISTFILE"
    rm -f "$tmpfile"
}

jump_to_history() {
    local target="$1"
    
    if [[ ! -f "$HISTFILE" ]]; then
        echo "No directory history. Use cdhistory after navigating to populate." >&2
        return 1
    fi
    
    local count=0
    local target_dir=""
    
    while IFS= read -r dir; do
        if [[ -n "$dir" && -d "$dir" ]]; then
            ((count++))
            if [[ $count -eq "$target" ]]; then
                target_dir="$dir"
                break
            fi
        fi
    done < "$HISTFILE"
    
    if [[ -z "$target_dir" ]]; then
        echo "Invalid history index: $target" >&2
        return 1
    fi
    
    echo "cd $target_dir"
    cd "$target_dir" || return 1
    echo "Switched to: $(pwd)"
}

# Parse arguments
case "${1:-}" in
    -l|--list)
        list_history
        ;;
    -c|--clear)
        clear_history
        ;;
    -h|--help)
        show_help
        ;;
    "")
        jump_to_history 1
        ;;
    *)
        if [[ "$1" =~ ^[0-9]+$ ]]; then
            jump_to_history "$1"
        else
            echo "Unknown option: $1" >&2
            show_help
            exit 1
        fi
        ;;
esac
