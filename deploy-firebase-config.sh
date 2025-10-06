#!/bin/bash

# =============================================================================
# Firebase Deployment Script (Configuration File Version)
# =============================================================================

set -e  # Exit on any error

# =============================================================================
# LOAD CONFIGURATION
# =============================================================================

if [ ! -f "firebase-config.env" ]; then
    echo "❌ Configuration file 'firebase-config.env' not found!"
    echo "📋 Please copy 'firebase-config.env' and update the values:"
    echo "   cp firebase-config.env firebase-config.env"
    echo "   # Then edit firebase-config.env with your actual values"
    exit 1
fi

# Load configuration
source firebase-config.env

echo "🚀 Starting Firebase deployment process..."
echo "📋 Configuration:"
echo "   Repository: $GITHUB_REPO"
echo "   Branch: $GITHUB_BRANCH"
echo "   Firebase Project: $FIREBASE_PROJECT_ID"
echo "   Strapi URL: $STRAPI_URL"
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
npm install

# =============================================================================
# FETCH CONTENT FROM STRAPI
# =============================================================================

echo "📡 Fetching content from Strapi..."

# Use the existing fetch-content.js from the repository
if [ -f "fetch-content.js" ]; then
    node fetch-content.js
else
    echo "⚠️ fetch-content.js not found, skipping content fetch"
fi

# =============================================================================
# BUILD STATIC SITE
# =============================================================================

echo "🔨 Building static site..."
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
    npm install -g firebase-tools
fi

# Login to Firebase (if not already logged in)
echo "🔐 Authenticating with Firebase..."
firebase login --no-localhost

# Initialize Firebase project (if not already initialized)
if [ ! -f "firebase.json" ]; then
    echo "⚙️ Initializing Firebase project..."
    firebase init hosting --project "$FIREBASE_PROJECT_ID" --public "$OUTPUT_DIR" --yes
fi

# Update firebase.json if needed
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

# Deploy to Firebase
echo "🚀 Deploying to Firebase Hosting..."
firebase deploy --project "$FIREBASE_PROJECT_ID" --only hosting

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
echo "🌐 Your site is now live at: https://$FIREBASE_HOSTING_SITE.web.app"
echo ""
echo "📋 Deployment Summary:"
echo "   ✅ Repository cloned from GitHub"
echo "   ✅ Dependencies installed"
echo "   ✅ Content fetched from Strapi"
echo "   ✅ Static site built"
echo "   ✅ Deployed to Firebase Hosting"
echo ""
echo "🔄 Next time you publish content in Strapi, just run this script again!"
