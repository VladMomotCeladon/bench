# Strapi Cloud Deployment Guide

## 🚀 Deploy Your Strapi Backend to Strapi Cloud

### Step 1: Prepare for Deployment

1. **Push your code to GitHub:**
   ```bash
   git add .
   git commit -m "Prepare for Strapi Cloud deployment"
   git push origin main
   ```

2. **Create a Strapi Cloud Account:**
   - Go to [Strapi Cloud Login](https://cloud.strapi.io/login)
   - Sign in with your GitHub account

### Step 2: Deploy to Strapi Cloud

1. **Create a New Project:**
   - Click "Create Project" in Strapi Cloud dashboard
   - Import your Strapi project from your GitHub repository
   - Provide project details:
     - **Display Name:** `Next.js Static Site Backend`
     - **Region:** Choose closest to your users
     - **Root Directory:** `strapi-backend` (if your Strapi is in a subfolder)
   - Click "Create project" to start deployment

2. **Wait for Deployment:**
   - Strapi Cloud will automatically:
     - Set up PostgreSQL database
     - Install dependencies
     - Configure environment variables
     - Deploy your Strapi backend

### Step 3: Get Your Cloud URL

After deployment, you'll get a URL like:
- `https://your-project-name.strapi.app`

### Step 4: Update Next.js Configuration

Update your `.env.local` file:
```env
NEXT_PUBLIC_STRAPI_URL=https://your-project-name.strapi.app
STRAPI_API_TOKEN=your-cloud-api-token
```

### Step 5: Create API Token in Strapi Cloud

1. **Go to your Strapi Cloud admin:** `https://your-project-name.strapi.app/admin`
2. **Go to Settings** → **API Tokens**
3. **Create new token:**
   - Name: `Next.js Static Site`
   - Token type: `Read-only`
   - Click "Save"
4. **Copy the token** and add it to your `.env.local`

### Step 6: Update Webhook Configuration

Update your webhook server to use the cloud URL:
- **Webhook URL:** `https://your-project-name.strapi.app/api/webhooks/rebuild`
- **Or keep local webhook** and update Strapi Cloud webhook settings

## 🔧 Environment Variables for Production

Create these in your Strapi Cloud dashboard:

```env
NODE_ENV=production
DATABASE_CLIENT=postgres
ADMIN_JWT_SECRET=your-secure-jwt-secret
API_TOKEN_SALT=your-secure-api-token-salt
TRANSFER_TOKEN_SALT=your-secure-transfer-token-salt
ENCRYPTION_KEY=your-secure-encryption-key
APP_KEYS=key1,key2,key3,key4
```

## 🎯 Benefits of Strapi Cloud

✅ **Always available** - No need to run local Strapi  
✅ **Automatic backups** - Your data is safe  
✅ **Scalable** - Handles traffic spikes  
✅ **Global CDN** - Fast content delivery  
✅ **SSL certificates** - Secure by default  
✅ **Monitoring** - Built-in analytics  

## 🚀 Next Steps After Deployment

1. **Test the API:** `https://your-project-name.strapi.app/api/homepage-contents`
2. **Update webhook URL** in Strapi Cloud settings
3. **Rebuild your Next.js site** with the new cloud URL
4. **Deploy your static site** to Vercel, Netlify, or any static host

## 📝 Important Notes

- **Content Migration:** Your existing content will be preserved
- **API Compatibility:** Same API endpoints work with cloud
- **Webhooks:** Configure in Strapi Cloud dashboard
- **Custom Domain:** Available in Strapi Cloud Pro plans
