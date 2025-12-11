#!/bin/bash
# Upload test package to PyPI

# Source .zshrc to load environment variables
if [ -f ~/.zshrc ]; then
    source ~/.zshrc 2>/dev/null || true
fi

# Check if API token is set
if [ -z "$PYPI_API_TOKEN" ]; then
    echo "ERROR: PYPI_API_TOKEN not set!"
    echo "Set it with: export PYPI_API_TOKEN='your-token'"
    exit 1
fi

# Build the package
echo "🔨 Building package..."
python -m build

if [ $? -ne 0 ]; then
    echo "❌ Build failed!"
    exit 1
fi

# Upload to PyPI
echo "📦 Uploading to PyPI..."
python -m twine upload \
    --username __token__ \
    --password "$PYPI_API_TOKEN" \
    dist/*

if [ $? -eq 0 ]; then
    echo "✅ Package uploaded successfully!"
    echo ""
    echo "You can now test the cleanup tool:"
    echo "  cd ../pypi-cleanup"
    echo "  ./run_cleanup.sh -p fleandr-test-package --query-only"
else
    echo "❌ Upload failed!"
    exit 1
fi

