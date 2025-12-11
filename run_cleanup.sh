#!/bin/bash
# Wrapper script for pypi-cleanup

# Source .zshrc to load environment variables if not already loaded
if [ -f ~/.zshrc ]; then
    source ~/.zshrc 2>/dev/null || true
fi

export PYTHONPATH="$(dirname "$0")/src/main/python"

# Username can be set via PYPI_CLEANUP_USERNAME environment variable
# Password can be set via PYPI_CLEANUP_PASSWORD environment variable (or will prompt)
# TOTP secret can be set via PYPI_CLEANUP_TOTP_SECRET environment variable

# Build command with username if provided
CMD="python \"$(dirname \"$0\")/src/main/python/pypi_cleanup/__init__.py\""
if [ -n "$PYPI_CLEANUP_USERNAME" ]; then
    CMD="$CMD -u \"$PYPI_CLEANUP_USERNAME\""
fi

# Pass through all arguments
eval "$CMD \"\$@\""

