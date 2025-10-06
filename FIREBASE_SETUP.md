# 🔥 Firebase Setup for Your Project

## 📋 Your Firebase Configuration

Based on your Firebase config, here are your project details:

- **Project ID**: `bench-463f3`
- **Auth Domain**: `bench-463f3.firebaseapp.com`
- **Storage Bucket**: `bench-463f3.firebasestorage.app`
- **Your Site URL**: `https://bench-463f3.web.app`

## 🚀 Quick Deployment

### Option 1: Deploy from Current Directory
```bash
./deploy-local.sh
```

### Option 2: Deploy from GitHub (Full Process)
```bash
./deploy-firebase-config.sh
```

## 🔧 Configuration Files Created

1. **`firebase.json`** - Firebase hosting configuration
2. **`.firebaserc`** - Project specification
3. **`deploy-local.sh`** - Local deployment script
4. **`firebase-config.env`** - Configuration template

## 📝 Next Steps

### 1. Update Configuration
Edit `firebase-config.env` with your actual values:
```bash
# Update these values:
GITHUB_REPO="https://github.com/yourusername/your-actual-repo.git"
STRAPI_URL="https://your-strapi-app.strapiapp.com"
STRAPI_API_TOKEN="your_actual_strapi_token"
```

### 2. Test Local Deployment
```bash
# Make sure Strapi is running locally
# Then run:
./deploy-local.sh
```

### 3. Test GitHub Deployment
```bash
# Push your code to GitHub first
# Then run:
./deploy-firebase-config.sh
```

## 🎯 What Happens During Deployment

1. **Fetch Content** - Gets latest content from Strapi
2. **Build Site** - Creates static files in `out/` directory
3. **Deploy to Firebase** - Uploads files to Firebase Hosting
4. **Site Goes Live** - Available at `https://bench-463f3.web.app`

## 🔄 Automatic Rebuilds

### Current Setup:
- **Manual**: Run deployment script when you publish content
- **Future**: Set up webhooks for automatic rebuilds

### Webhook Setup (Advanced):
1. Create a webhook server that runs the deployment script
2. Configure Strapi to send webhooks to your server
3. Automatic rebuilds when content is published

## 🚨 Troubleshooting

### Firebase CLI Issues:
```bash
# Install Firebase CLI
npm install -g firebase-tools

# Login to Firebase
firebase login
```

### Build Issues:
- Make sure all dependencies are in `package.json`
- Check that Strapi is running and accessible
- Verify API token is correct

### Deployment Issues:
- Check Firebase project permissions
- Verify project ID is correct
- Make sure hosting is enabled in Firebase Console

## 🎉 Success!

Once deployed, your site will be available at:
**https://bench-463f3.web.app**

## 📞 Next Steps

1. **Test the deployment** - Run `./deploy-local.sh`
2. **Update content** in Strapi and redeploy
3. **Set up custom domain** (optional)
4. **Configure automatic rebuilds** (advanced)
