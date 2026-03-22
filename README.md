# CLI Utils

A collection of useful command-line utilities.

## Installation

```bash
# Clone this repo
git clone https://github.com/zeusa1labs/cli-utils.git ~/cli-utils

# Add to your shell config (~/.bashrc or ~/.zshrc)
export PATH="$HOME/cli-utils:$PATH"

# For cdhistory (recommended):
source ~/cli-utils/cdhistory/track.sh
```

## cdhistory

Track and quickly navigate your directory history.

### Features

- Automatically tracks directory navigation
- Quick jump to previous directories
- List history with indices
- Configurable history size

### Usage

```bash
cd /some/path
cd /another/path
cd /yet/another

# Go back to previous directory
cdhistory

# Go back 2 directories
cdhistory 2

# List history
cdhistory -l

# Clear history
cdhistory -c

# Show help
cdhistory -h
```

### Configuration

```bash
# Custom history file location
export CDHISTORY_FILE="/path/to/custom/history"
```

## License

MIT
