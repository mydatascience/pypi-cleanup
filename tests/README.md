# Test Package for PyPI Cleanup

This directory contains test utilities and a test package used to verify the pypi-cleanup tool functionality.

## Setup

1. Make sure you have `PYPI_API_TOKEN` set in your environment
2. Make sure you have `PYPI_CLEANUP_TOTP_SECRET` set in your environment
3. Make sure you have `PYPI_CLEANUP_USERNAME` set in your environment (optional, can use -u flag)

## Utilities

### Show TOTP token:
```bash
cd tests
./show_totp.sh
```

### Upload package to PyPI:
```bash
cd tests
./upload_to_pypi.sh
```

## Test Package Usage

### Upload multiple test versions:

```bash
cd tests/test-pypi-package
./upload_multiple_versions.sh
```

This will upload:
- 0.1.0.dev1
- 0.1.0.dev2
- 0.1.0.dev3
- 0.1.0 (non-dev)
- 0.1.1.dev1
- 0.1.1.dev2

### Test cleanup:

```bash
cd ../..
./run_cleanup.sh -p fleandr-test-package --query-only
```

### Clean up dev versions:

```bash
./run_cleanup.sh -p fleandr-test-package --do-it -y
```

