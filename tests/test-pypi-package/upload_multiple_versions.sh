#!/bin/bash
# Upload multiple versions of the test package

# Source .zshrc to load environment variables
if [ -f ~/.zshrc ]; then
    source ~/.zshrc 2>/dev/null || true
fi

# Check if API token is set
if [ -z "$PYPI_API_TOKEN" ]; then
    echo "ERROR: PYPI_API_TOKEN not set!"
    exit 1
fi

# Versions to upload
VERSIONS=("0.1.0.dev1" "0.1.0.dev2" "0.1.0.dev3" "0.1.0" "0.1.1.dev1" "0.1.1.dev2")

for version in "${VERSIONS[@]}"; do
    echo ""
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    echo "📦 Building and uploading version: $version"
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    
    # Update version in setup.py
    sed -i.bak "s/version=\".*\"/version=\"$version\"/" setup.py
    
    # Update version in fleandr_test.py
    sed -i.bak "s/__version__ = \".*\"/__version__ = \"$version\"/" fleandr_test.py
    
    # Clean previous builds
    rm -rf build dist *.egg-info
    
    # Build
    python -m build > /dev/null 2>&1
    
    if [ $? -ne 0 ]; then
        echo "❌ Build failed for $version"
        continue
    fi
    
    # Upload
    python -m twine upload \
        --username __token__ \
        --password "$PYPI_API_TOKEN" \
        --skip-existing \
        dist/* > /dev/null 2>&1
    
    if [ $? -eq 0 ]; then
        echo "✅ Successfully uploaded $version"
    else
        echo "⚠️  Upload failed or skipped for $version (might already exist)"
    fi
    
    # Small delay between uploads
    sleep 2
done

# Restore original files
if [ -f setup.py.bak ]; then
    mv setup.py.bak setup.py
fi
if [ -f fleandr_test.py.bak ]; then
    mv fleandr_test.py.bak fleandr_test.py
fi

echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "✅ Finished uploading multiple versions!"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"

