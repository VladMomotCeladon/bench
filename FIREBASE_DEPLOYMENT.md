# 🚀 Firebase Deployment Guide

This guide will help you deploy your Next.js + Strapi static site to Firebase Hosting with automatic rebuilds.

## 📋 Prerequisites

1. **GitHub Repository** - Your Next.js project pushed to GitHub
2. **Firebase Project** - Created at [Firebase Console](https://console.firebase.google.com)
3. **Strapi Cloud** - Your Strapi backend deployed to Strapi Cloud
4. **Firebase CLI** - Will be installed automatically by the script

## 🔧 Setup Steps

### Step 1: Configure Firebase Project

1. Go to [Firebase Console](https://console.firebase.google.com)
2. Create a new project or select existing one
3. Enable **Firebase Hosting**
4. Note your **Project ID** and **Hosting Site ID**

### Step 2: Configure Deployment Script

1. Copy the configuration template:
   ```bash
   cp firebase-config.env firebase-config.env
   ```

2. Edit `firebase-config.env` with your actual values:
   ```bash
   # GitHub Repository Configuration
   GITHUB_REPO="https://github.com/yourusername/your-repo-name.git"
   GITHUB_BRANCH="main"
   
   # Firebase Configuration
   FIREBASE_PROJECT_ID="your-firebase-project-id"
   FIREBASE_HOSTING_SITE="your-hosting-site-id"
   
   # Strapi Configuration
   STRAPI_URL="https://your-strapi-app.strapiapp.com"
   STRAPI_API_TOKEN="your_strapi_api_token"
   ```

### Step 3: Run Deployment Script

```bash
./deploy-firebase-config.sh
```

## 🔄 How It Works

### Deployment Process:
1. **Clone Repository** - Pulls latest code from GitHub
2. **Setup Environment** - Creates `.env.local` with Strapi credentials
3. **Install Dependencies** - Runs `npm install`
4. **Fetch Content** - Gets latest content from Strapi
5. **Build Site** - Runs `npm run build` to create static files
6. **Deploy to Firebase** - Uploads static files to Firebase Hosting

### Automatic Rebuilds:
1. **Publish Content** in Strapi Cloud
2. **Run Deployment Script** (manually or via webhook)
3. **Site Updates** automatically with new content

## 🎯 Webhook Integration

### Option 1: Manual Deployment
- Run `./deploy-firebase-config.sh` whenever you publish content

### Option 2: Automated Webhook (Advanced)
- Set up a webhook server that runs the deployment script
- Configure Strapi to send webhooks to your server
- Automatic rebuilds when content is published

## 📊 File Structure

```
your-project/
├── deploy-firebase-config.sh    # Main deployment script
├── firebase-config.env          # Configuration file
├── firebase-config.env          # Template (copy and edit)
└── FIREBASE_DEPLOYMENT.md       # This guide
```

## 🔧 Configuration Options

### GitHub Repository:
- **GITHUB_REPO**: Full URL to your GitHub repository
- **GITHUB_BRANCH**: Branch to deploy (usually "main")

### Firebase:
- **FIREBASE_PROJECT_ID**: Your Firebase project ID
- **FIREBASE_HOSTING_SITE**: Your hosting site ID

### Strapi:
- **STRAPI_URL**: Your Strapi Cloud URL
- **STRAPI_API_TOKEN**: API token for content access

## 🚨 Troubleshooting

### Common Issues:

1. **Firebase CLI not found**
   - Script will install it automatically
   - Or install manually: `npm install -g firebase-tools`

2. **Authentication failed**
   - Run `firebase login` manually
   - Make sure you have access to the Firebase project

3. **Build failed**
   - Check your GitHub repository is accessible
   - Verify all dependencies are in `package.json`
   - Check Strapi API token is valid

4. **Content not updating**
   - Verify Strapi URL and API token
   - Check Strapi API permissions
   - Ensure content is published in Strapi

## 🎉 Success!

Once deployed, your site will be available at:
```
https://your-hosting-site-id.web.app
```

## 🔄 Next Steps

1. **Test the deployment** - Visit your Firebase Hosting URL
2. **Update content** in Strapi and redeploy
3. **Set up custom domain** (optional)
4. **Configure webhooks** for automatic rebuilds (advanced)

## 📞 Support

If you encounter issues:
1. Check the script output for error messages
2. Verify all configuration values are correct
3. Ensure you have proper permissions for GitHub and Firebase
4. Check Strapi API is accessible and returning data
