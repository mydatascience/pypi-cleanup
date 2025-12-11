#!/bin/bash
# Quick wrapper to show current TOTP token

# Source .zshrc to load environment variables if not already loaded
if [ -f ~/.zshrc ] && [ -z "$PYPI_CLEANUP_TOTP_SECRET" ]; then
    source ~/.zshrc 2>/dev/null || true
fi

export PYTHONPATH="$(dirname "$0")/src/main/python"
python "$(dirname "$0")/show_totp.py" "$@"

