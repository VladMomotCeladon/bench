#!/bin/bash

echo "🚀 Setting up Next.js + Strapi Static Site Project"
echo "=================================================="

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Function to print colored output
print_status() {
    echo -e "${GREEN}✅ $1${NC}"
}

print_info() {
    echo -e "${BLUE}ℹ️  $1${NC}"
}

print_warning() {
    echo -e "${YELLOW}⚠️  $1${NC}"
}

print_error() {
    echo -e "${RED}❌ $1${NC}"
}

# Check if Node.js is installed
if ! command -v node &> /dev/null; then
    print_error "Node.js is not installed. Please install Node.js first."
    exit 1
fi

print_status "Node.js is installed: $(node --version)"

# Install Next.js dependencies
print_info "Installing Next.js dependencies..."
cd /Users/vladislavmomot/Bench
npm install

if [ $? -eq 0 ]; then
    print_status "Next.js dependencies installed successfully"
else
    print_error "Failed to install Next.js dependencies"
    exit 1
fi

# Start Strapi in the background
print_info "Starting Strapi backend..."
cd /Users/vladislavmomot/Bench/strapi-backend
npm run develop &
STRAPI_PID=$!

# Wait for Strapi to start
print_info "Waiting for Strapi to start (this may take a moment)..."
sleep 10

# Check if Strapi is running
if curl -s http://localhost:1337/admin > /dev/null; then
    print_status "Strapi is running on http://localhost:1337"
else
    print_warning "Strapi might still be starting up. Please check http://localhost:1337/admin manually."
fi

# Go back to project root
cd /Users/vladislavmomot/Bench

echo ""
echo "🎉 Setup Complete!"
echo "=================="
echo ""
echo "📋 Next Steps:"
echo "1. Open http://localhost:1337/admin in your browser"
echo "2. Create your Strapi admin account"
echo "3. The 'Homepage Content' content type is already configured"
echo "4. Public permissions are automatically set"
echo "5. Initial content is already created"
echo ""
echo "🔧 To rebuild your Next.js site:"
echo "   ./rebuild.sh"
echo ""
echo "🌐 To start the Next.js development server:"
echo "   npm run dev"
echo ""
echo "📁 Project Structure:"
echo "   - Next.js frontend: /Users/vladislavmomot/Bench"
echo "   - Strapi backend: /Users/vladislavmomot/Bench/strapi-backend"
echo ""
echo "💡 The Strapi backend is running in the background (PID: $STRAPI_PID)"
echo "   To stop it later, run: kill $STRAPI_PID"
echo ""
print_status "Setup completed successfully!"
