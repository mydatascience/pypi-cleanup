#!/bin/bash
# Upload package to PyPI using API token

# Source .zshrc to load environment variables
if [ -f ~/.zshrc ]; then
    source ~/.zshrc 2>/dev/null || true
fi

# Check if API token is set
if [ -z "$PYPI_API_TOKEN" ]; then
    echo "ERROR: PYPI_API_TOKEN not set!"
    echo "Set it with: export PYPI_API_TOKEN='your-token'"
    echo "Or add it to ~/.zshrc"
    exit 1
fi

# Check if package files exist
if [ ! -d "dist" ] || [ -z "$(ls -A dist 2>/dev/null)" ]; then
    echo "ERROR: No package files found in dist/ directory"
    echo "Build the package first with: python -m build"
    exit 1
fi

echo "📦 Uploading package to PyPI..."
echo "Using API token: ${PYPI_API_TOKEN:0:20}..."

# Upload using twine with API token
python -m twine upload \
    --username __token__ \
    --password "$PYPI_API_TOKEN" \
    dist/*

if [ $? -eq 0 ]; then
    echo "✅ Package uploaded successfully!"
else
    echo "❌ Upload failed!"
    exit 1
fi

