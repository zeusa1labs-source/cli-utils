# CLI Utils

A collection of useful command-line utilities for daily productivity.

## Installation

### Homebrew (Recommended)

```bash
brew tap zeusa1labs/cli-utils
brew install cli-utils
```

### Manual Installation

```bash
# Clone this repo
git clone https://github.com/zeusa1labs/cli-utils.git ~/cli-utils

# Add to your PATH
export PATH="$HOME/cli-utils:$PATH"

# For cdhistory shell integration, see below
```

## Utilities

### cdhistory

Track and quickly navigate your directory history — never lose track of where you've been.

#### Features

- Automatically tracks directory navigation history
- Quick jump to previous directories
- List history with indices
- Configurable history size
- Works with bash, zsh, and fish

#### Usage

```bash
# After navigating, go back to previous directory
cdhistory

# Go back 2 directories
cdhistory 2

# Go back 3 directories
cdhistory 3

# List history with indices
cdhistory -l

# Clear history
cdhistory -c

# Show help
cdhistory -h
```

#### Shell Integration

**Bash** — Add to `~/.bashrc`:

```bash
# Source the tracker (use full path if not in PATH)
source ~/cli-utils/cdhistory/track.sh
```

**Zsh** — Add to `~/.zshrc`:

```bash
# Source the tracker
source ~/cli-utils/cdhistory/track.sh
```

**Fish** — Add to `~/.config/fish/config.fish`:

```fish
# Source the tracker
source ~/cli-utils/cdhistory/track.fish
```

#### Configuration

```bash
# Custom history file location
export CDHISTORY_FILE="/path/to/custom/history"

# Custom history size (default: 20)
export CDHISTORY_SIZE=50
```

#### How It Works

1. When you `cd` to a new directory, it's added to your history file (`~/.cdhistory` by default)
2. Running `cdhistory` pops the most recent directory and `cd`s to it
3. Running `cdhistory 2` goes back 2 directories, etc.

#### Examples

```bash
# Typical workflow
cd ~/Projects
cd ~/Documents
cd /tmp
cdhistory        # Returns to /tmp's previous: ~/Documents
cdhistory        # Returns to ~/Documents's previous: ~/Projects
cdhistory -l     # Shows: 1: /tmp (current), 2: ~/Documents, 3: ~/Projects
```

## Troubleshooting

### "No directory history"

This means you haven't navigated to any directories since enabling the tracker. 
Try:
```bash
cd ~/some/directory
cdhistory
```

### "Invalid history index"

The index you specified is larger than your history. Use `cdhistory -l` to see available entries.

### History not persisting between terminal sessions

Make sure you're sourcing `track.sh` in your shell config (~/.bashrc or ~/.zshrc), not just running it directly.

### Permission denied errors

Ensure the history file is writable:
```bash
touch ~/.cdhistory
chmod 600 ~/.cdhistory
```

## Uninstallation

```bash
# Remove Homebrew installation
brew uninstall cli-utils
brew untap zeusa1labs/cli-utils

# Or remove manual installation
rm -rf ~/cli-utils
rm ~/.cdhistory
```

## Contributing

Contributions welcome! Please open an issue or PR at:
https://github.com/zeusa1labs/cli-utils

## License

MIT License — see LICENSE file for details.
