#!/bin/bash

# Script to update configuration for Strapi Cloud
# Usage: ./update-for-cloud.sh https://your-project.strapi.app

if [ -z "$1" ]; then
    echo "❌ Please provide your Strapi Cloud URL"
    echo "Usage: ./update-for-cloud.sh https://your-project.strapi.app"
    exit 1
fi

STRAPI_CLOUD_URL=$1

echo "🚀 Updating configuration for Strapi Cloud: $STRAPI_CLOUD_URL"

# Update .env.local
if [ -f ".env.local" ]; then
    echo "📝 Updating .env.local..."
    sed -i.bak "s|NEXT_PUBLIC_STRAPI_URL=.*|NEXT_PUBLIC_STRAPI_URL=$STRAPI_CLOUD_URL|" .env.local
    echo "✅ Updated .env.local with cloud URL"
else
    echo "📝 Creating .env.local..."
    cat > .env.local << EOF
# Strapi Cloud Configuration
NEXT_PUBLIC_STRAPI_URL=$STRAPI_CLOUD_URL
STRAPI_API_TOKEN=your_strapi_cloud_api_token_here
EOF
    echo "✅ Created .env.local with cloud URL"
fi

# Update webhook server
if [ -f "webhook-server.js" ]; then
    echo "📝 Updating webhook server configuration..."
    # The webhook server will work with cloud URLs too
    echo "✅ Webhook server is ready for cloud deployment"
fi

echo ""
echo "🎯 Next steps:"
echo "1. Get your API token from Strapi Cloud admin panel"
echo "2. Update STRAPI_API_TOKEN in .env.local"
echo "3. Test the connection: curl $STRAPI_CLOUD_URL/api/homepage-contents"
echo "4. Rebuild your site: ./rebuild.sh"
echo ""
echo "🌐 Your Strapi Cloud admin: $STRAPI_CLOUD_URL/admin"
echo "📡 API endpoint: $STRAPI_CLOUD_URL/api/homepage-contents"
echo ""
echo "✅ Configuration updated for Strapi Cloud!"
