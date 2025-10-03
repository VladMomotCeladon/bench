#!/bin/bash

# Rebuild script for Next.js + Strapi static site
echo "🚀 Starting rebuild process..."

# Install dependencies if needed
if [ ! -d "node_modules" ]; then
    echo "📦 Installing dependencies..."
    npm install
fi

# Build the static site
echo "🔨 Building static site..."
npm run build

# Check if build was successful
if [ $? -eq 0 ]; then
    echo "✅ Build completed successfully!"
    echo "📁 Static files generated in 'out' directory"
    echo ""
    echo "🌐 To serve the site locally, run:"
    echo "   npx serve out"
    echo ""
    echo "📤 To deploy, upload the contents of the 'out' directory to your hosting provider"
else
    echo "❌ Build failed. Please check the error messages above."
    exit 1
fi
