# Setup Guide

## Required Environment Variables

Set these in your `~/.zshrc` (or `~/.bashrc`):

```bash
# PyPI username (optional, can also use -u flag)
export PYPI_CLEANUP_USERNAME='your-username'

# Password for PyPI authentication (optional, will prompt if not set)
export PYPI_CLEANUP_PASSWORD='your-password'

# TOTP secret for automatic 2FA code generation
export PYPI_CLEANUP_TOTP_SECRET='your-totp-secret-here'

# PyPI API token for uploading packages (for upload scripts)
export PYPI_API_TOKEN='pypi-your-token-here'
```

## Getting Your TOTP Secret

1. Go to https://pypi.org/manage/account/
2. Navigate to "Two-Factor Authentication"
3. Copy your TOTP secret (or extract it from the QR code URL: `otpauth://totp/...?secret=YOUR_SECRET&...`)

## Usage

### Show current TOTP token:
```bash
cd tests
./show_totp.sh
```

### Run cleanup tool:
```bash
# Query mode (safe, no auth needed)
./run_cleanup.sh -p your-package-name --query-only

# Dry run (authenticates, shows what would be deleted)
./run_cleanup.sh -p your-package-name

# Actually delete (requires --do-it and -y flags)
./run_cleanup.sh -p your-package-name --do-it -y
```

## Testing

See `tests/README.md` for test package setup and usage.

