#!/usr/bin/env python
# -*- coding: utf-8 -*-
"""
Display the current TOTP token for PyPI authentication.

Requires PYPI_CLEANUP_TOTP_SECRET environment variable to be set.
Get your TOTP secret from PyPI account settings: https://pypi.org/manage/account/

Usage:
    export PYPI_CLEANUP_TOTP_SECRET='your-secret-here'
    python show_totp.py
"""

import sys
import os
import time

try:
    import pyotp
except ImportError:
    print("ERROR: pyotp is required. Install it with: pip install pyotp")
    sys.exit(1)


def show_totp(secret=None):
    """Display the current TOTP token."""
    if secret is None:
        secret = os.getenv("PYPI_CLEANUP_TOTP_SECRET")
    
    if not secret:
        print("ERROR: PYPI_CLEANUP_TOTP_SECRET environment variable not set!")
        print("\nSet it with:")
        print("  export PYPI_CLEANUP_TOTP_SECRET='your-secret-here'")
        print("\nGet your TOTP secret from: https://pypi.org/manage/account/")
        sys.exit(1)
    
    try:
        totp = pyotp.TOTP(secret)
        current_token = totp.now()
        
        # Calculate time remaining until next token
        time_remaining = 30 - (int(time.time()) % 30)
        
        print(f"Current TOTP Token: {current_token}")
        print(f"Valid for: {time_remaining} more seconds")
        print(f"\nNext token will be generated in: {time_remaining} seconds")
        
        return current_token
        
    except Exception as e:
        print(f"ERROR: Failed to generate TOTP token: {e}")
        print("\nMake sure your TOTP secret is correct (base32 encoded string)")
        sys.exit(1)


def main():
    if len(sys.argv) > 1 and sys.argv[1] in ("-h", "--help"):
        print(__doc__)
        sys.exit(0)
    
    show_totp()


if __name__ == "__main__":
    main()

