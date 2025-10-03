#!/bin/bash

echo "🚀 Preparing project for Strapi Cloud deployment..."

# Colors for output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

print_status() {
    echo -e "${GREEN}✅ $1${NC}"
}

print_info() {
    echo -e "${BLUE}ℹ️  $1${NC}"
}

print_warning() {
    echo -e "${YELLOW}⚠️  $1${NC}"
}

# Check if we're in a git repository
if [ ! -d ".git" ]; then
    print_warning "Not in a git repository. Initializing..."
    git init
    git add .
    git commit -m "Initial commit: Next.js + Strapi static site generator"
fi

# Check if remote origin exists
if ! git remote get-url origin > /dev/null 2>&1; then
    print_info "No remote origin found. You'll need to:"
    echo "1. Create a GitHub repository"
    echo "2. Add it as remote: git remote add origin https://github.com/yourusername/your-repo.git"
    echo "3. Push your code: git push -u origin main"
    echo ""
    print_warning "Please set up your GitHub repository first, then run this script again."
    exit 1
fi

# Check for uncommitted changes
if ! git diff --quiet || ! git diff --cached --quiet; then
    print_info "Found uncommitted changes. Committing them..."
    git add .
    git commit -m "Prepare for Strapi Cloud deployment"
fi

# Push to GitHub
print_info "Pushing to GitHub..."
git push origin main

if [ $? -eq 0 ]; then
    print_status "Code pushed to GitHub successfully!"
    echo ""
    print_info "Next steps:"
    echo "1. Go to https://cloud.strapi.io/login"
    echo "2. Sign in with your GitHub account"
    echo "3. Click 'Create Project'"
    echo "4. Import your repository"
    echo "5. Set root directory to 'strapi-backend'"
    echo "6. Deploy your project"
    echo ""
    print_status "Your project is ready for Strapi Cloud deployment!"
else
    print_warning "Failed to push to GitHub. Please check your git configuration."
    exit 1
fi
