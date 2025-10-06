#!/bin/bash

# =============================================================================
# Local Firebase Deployment Script
# =============================================================================

set -e  # Exit on any error

# =============================================================================
# CONFIGURATION
# =============================================================================

FIREBASE_PROJECT_ID="bench-463f3"
STRAPI_URL="http://localhost:1337"  # Change to your Strapi Cloud URL when ready
STRAPI_API_TOKEN="your_strapi_api_token"  # Update with your actual token

echo "🚀 Starting local Firebase deployment..."
echo "📋 Configuration:"
echo "   Firebase Project: $FIREBASE_PROJECT_ID"
echo "   Strapi URL: $STRAPI_URL"
echo ""

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
# FETCH CONTENT FROM STRAPI
# =============================================================================

echo "📡 Fetching content from Strapi..."
node fetch-content.js

# =============================================================================
# BUILD STATIC SITE
# =============================================================================

echo "🔨 Building static site..."
npm run build

# Check if build was successful
if [ ! -d "out" ]; then
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

# Deploy to Firebase
echo "🚀 Deploying to Firebase Hosting..."
firebase deploy --project "$FIREBASE_PROJECT_ID" --only hosting

# =============================================================================
# SUCCESS MESSAGE
# =============================================================================

echo ""
echo "🎉 Deployment completed successfully!"
echo "🌐 Your site is now live at: https://$FIREBASE_PROJECT_ID.web.app"
echo ""
echo "📋 Deployment Summary:"
echo "   ✅ Content fetched from Strapi"
echo "   ✅ Static site built"
echo "   ✅ Deployed to Firebase Hosting"
echo ""
echo "🔄 Next time you publish content in Strapi, just run this script again!"
