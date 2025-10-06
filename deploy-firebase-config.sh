#!/bin/bash

# =============================================================================
# Firebase Deployment Script
# =============================================================================

set -e  # Exit on any error

# =============================================================================
# CONFIGURATION CONSTANTS
# =============================================================================

# GitHub Repository Configuration
GITHUB_REPO="git@github.com:VladMomotCeladon/bench.git"
GITHUB_BRANCH="master"

# Firebase Configuration
FIREBASE_PROJECT_ID="bench-463f3"
FIREBASE_HOSTING_SITE="bench-463f3"

# Strapi Configuration
STRAPI_URL="http://localhost:1337"
STRAPI_API_TOKEN="9856012f998b9fc6b609a3ce7cdc7362bffcf47d24381d92b9a009689bf6a52de3f5a1cd24c9e116551376730ec0b708405ecb24fd66cfc8c489deb0401b560dcc7bcd08be81425c90ec19355b0751e51c1d664a608741fd806a84c194e88699f2251e517bbcafc550619b91658925f118b202cd4c636ee3e9a28ad7a5dd4c04"

# Build Configuration
BUILD_DIR="build-temp"
OUTPUT_DIR="out"
NODE_VERSION="20.19.4"

echo "🚀 Starting Firebase deployment process..."
echo "📋 Configuration:"
echo "   Repository: $GITHUB_REPO"
echo "   Branch: $GITHUB_BRANCH"
echo "   Firebase Project: $FIREBASE_PROJECT_ID"
echo "   Strapi URL: $STRAPI_URL"
echo "   Node.js Version: $NODE_VERSION"
echo ""

# =============================================================================
# CLEANUP PREVIOUS BUILD
# =============================================================================

echo "🧹 Cleaning up previous build..."
if [ -d "$BUILD_DIR" ]; then
    rm -rf "$BUILD_DIR"
fi

# =============================================================================
# CLONE REPOSITORY
# =============================================================================

echo "📥 Cloning repository from GitHub..."
git clone --depth 1 --branch "$GITHUB_BRANCH" "$GITHUB_REPO" "$BUILD_DIR"
cd "$BUILD_DIR"

# =============================================================================
# SETUP ENVIRONMENT
# =============================================================================

echo "🔧 Setting up environment..."

# Create .env.local file
cat > .env.local << EOF
NEXT_PUBLIC_STRAPI_URL=$STRAPI_URL
STRAPI_API_TOKEN=$STRAPI_API_TOKEN
EOF

echo "✅ Environment variables configured"

# =============================================================================
# INSTALL DEPENDENCIES
# =============================================================================

echo "📦 Installing dependencies..."
# Use Node.js version from config for the build process
export PATH="/Users/vladislavmomot/.nvm/versions/node/v${NODE_VERSION}/bin:$PATH"
echo "🔧 Using Node.js version: $(node --version)"
npm install

# =============================================================================
# FETCH CONTENT FROM STRAPI
# =============================================================================

echo "📡 Fetching content from Strapi..."

# Use the existing fetch-content.js from the repository
if [ -f "fetch-content.js" ]; then
    # Use Node.js version from config for the fetch process
    export PATH="/Users/vladislavmomot/.nvm/versions/node/v${NODE_VERSION}/bin:$PATH"
    node fetch-content.js
else
    echo "⚠️ fetch-content.js not found, skipping content fetch"
fi

# =============================================================================
# BUILD STATIC SITE
# =============================================================================

echo "🔨 Building static site..."
# Use Node.js version from config for the build process
export PATH="/Users/vladislavmomot/.nvm/versions/node/v${NODE_VERSION}/bin:$PATH"
npm run build

# Check if build was successful
if [ ! -d "$OUTPUT_DIR" ]; then
    echo "❌ Build failed - output directory not found"
    exit 1
fi

echo "✅ Build completed successfully!"

# =============================================================================
# DEPLOY TO FIREBASE
# =============================================================================

echo "🔥 Deploying to Firebase Hosting..."

# Check if Firebase CLI is installed
if ! command -v firebase &> /dev/null; then
    echo "📦 Installing Firebase CLI..."
    npm install -g firebase-tools@latest
fi

# Create firebase.json
cat > firebase.json << EOF
{
  "hosting": {
    "public": "$OUTPUT_DIR",
    "ignore": [
      "firebase.json",
      "**/.*",
      "**/node_modules/**"
    ],
    "rewrites": [
      {
        "source": "**",
        "destination": "/index.html"
      }
    ]
  }
}
EOF

# Create .firebaserc
cat > .firebaserc << EOF
{
  "projects": {
    "default": "$FIREBASE_PROJECT_ID"
  }
}
EOF

# Deploy to Firebase
echo "🚀 Deploying to Firebase Hosting..."
firebase deploy --only hosting --project "$FIREBASE_PROJECT_ID"

# =============================================================================
# CLEANUP
# =============================================================================

echo "🧹 Cleaning up build directory..."
cd ..
rm -rf "$BUILD_DIR"

# =============================================================================
# SUCCESS MESSAGE
# =============================================================================

echo ""
echo "🎉 Deployment completed successfully!"
echo "🌐 Your site is now live at: https://${FIREBASE_HOSTING_SITE}.web.app"
echo ""
echo "📋 Deployment Summary:"
echo "   ✅ Repository cloned from GitHub"
echo "   ✅ Dependencies installed"
echo "   ✅ Content fetched from Strapi"
echo "   ✅ Static site built"
echo "   ✅ Deployed to Firebase Hosting"
echo ""
echo "🔄 Next time you publish content in Strapi, just run this script again!"
