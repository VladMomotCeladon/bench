# Detailed Strapi Setup Guide

This guide provides step-by-step instructions for setting up Strapi to work with your Next.js static site.

## 🎯 Overview

You'll create a Strapi backend that serves content to your Next.js frontend. The content can be updated through Strapi's admin panel, and your static site can be rebuilt to reflect these changes.

## 📋 Prerequisites

- Node.js (v18 or higher)
- npm or yarn
- Basic understanding of content management systems

## 🚀 Step-by-Step Setup

### Step 1: Create Strapi Project

1. **Open your terminal and run:**
   ```bash
   npx create-strapi-app@latest my-strapi-project --quickstart
   ```

2. **Navigate to the project directory:**
   ```bash
   cd my-strapi-project
   ```

3. **Start the development server:**
   ```bash
   npm run develop
   ```

4. **Access the admin panel:**
   - Open your browser and go to: http://localhost:1337/admin
   - You'll see the Strapi welcome screen

### Step 2: Create Admin Account

1. **Fill out the registration form:**
   - First Name: Your first name
   - Last Name: Your last name
   - Username: Choose a username
   - Password: Create a strong password
   - Confirm Password: Re-enter your password
   - Email: Your email address

2. **Click "Let's start"**

### Step 3: Create Content Type

1. **Navigate to Content-Type Builder:**
   - In the left sidebar, click "Content-Type Builder"
   - This is where you'll define your content structure

2. **Create a new Collection Type:**
   - Click the "+ Create new collection type" button
   - **Display name:** `Homepage Content`
   - **API ID (singular):** `homepage-content`
   - **API ID (plural):** `homepage-contents`
   - Click "Continue"

3. **Add Title Field:**
   - Click "Add another field"
   - Select "Text"
   - **Name:** `title`
   - **Type:** Short text
   - **Required:** Toggle ON
   - Click "Finish"

4. **Add Content Field:**
   - Click "Add another field"
   - Select "Text"
   - **Name:** `content`
   - **Type:** Long text
   - **Required:** Toggle ON
   - Click "Finish"

5. **Save the Content Type:**
   - Click "Save" in the top right corner
   - You'll see a success message

### Step 4: Configure API Permissions

1. **Go to Settings:**
   - Click "Settings" in the left sidebar
   - Click "Users & Permissions Plugin"
   - Click "Roles"

2. **Configure Public Role:**
   - Click on "Public" role
   - Scroll down to find "Homepage Content"
   - Check the "find" permission (this allows public access to read content)
   - Click "Save"

### Step 5: Create API Token (Recommended)

1. **Go to API Tokens:**
   - In Settings, click "API Tokens"
   - Click "Create new API Token"

2. **Configure the Token:**
   - **Token name:** `Next.js Static Site`
   - **Token description:** `Token for Next.js static site generation`
   - **Token duration:** Unlimited
   - **Token type:** Read-only
   - Click "Save"

3. **Copy the Token:**
   - **IMPORTANT:** Copy the generated token immediately
   - You won't be able to see it again
   - Add it to your Next.js `.env.local` file

### Step 6: Add Content

1. **Go to Content Manager:**
   - Click "Content Manager" in the left sidebar
   - Click "Homepage Content"
   - Click "Create new entry"

2. **Fill in the Content:**
   - **Title:** `Hello World!`
   - **Content:** `This is a static site generated with Next.js and powered by Strapi CMS. You can edit this content in Strapi and rebuild the site to see changes.`

3. **Save and Publish:**
   - Click "Save" (draft will be created)
   - Click "Publish" to make it live
   - You'll see a green "Published" status

### Step 7: Test the API

1. **Test the API endpoint:**
   - Open a new browser tab
   - Go to: http://localhost:1337/api/homepage-contents
   - You should see JSON data with your content

2. **Test with authentication (if using API token):**
   - Add `?populate=*` to the URL: http://localhost:1337/api/homepage-contents?populate=*
   - This will include all related data

## 🔧 Configuration for Next.js

### Environment Variables

Create a `.env.local` file in your Next.js project root:

```env
# Strapi Configuration
NEXT_PUBLIC_STRAPI_URL=http://localhost:1337
STRAPI_API_TOKEN=your_copied_token_here
```

### API Endpoint Structure

Your Strapi API will be available at:
- **Base URL:** `http://localhost:1337/api`
- **Homepage Content:** `http://localhost:1337/api/homepage-contents`
- **With Population:** `http://localhost:1337/api/homepage-contents?populate=*`

## 🔄 Content Management Workflow

### Updating Content

1. **Login to Strapi Admin:**
   - Go to http://localhost:1337/admin
   - Login with your admin credentials

2. **Edit Content:**
   - Go to Content Manager
   - Click on "Homepage Content"
   - Click on your content entry
   - Make your changes
   - Click "Save" then "Publish"

3. **Rebuild Your Site:**
   - In your Next.js project, run: `./rebuild.sh`
   - This will fetch the latest content and rebuild the static site

### Adding More Content Types

To add more content types (e.g., blog posts, products):

1. **Create New Content Type in Strapi:**
   - Go to Content-Type Builder
   - Create new collection type
   - Add required fields

2. **Update API Permissions:**
   - Go to Settings > Roles > Public
   - Enable "find" permission for the new content type

3. **Update Next.js Code:**
   - Add new interfaces in `lib/strapi.ts`
   - Create new API functions
   - Use in your pages

## 🚨 Troubleshooting

### Common Issues

1. **"Access denied" or 403 errors:**
   - Check API permissions in Settings > Roles > Public
   - Ensure "find" permission is enabled for your content type

2. **"Not found" or 404 errors:**
   - Verify the API endpoint URL is correct
   - Check if content is published (not just saved as draft)
   - Ensure Strapi server is running

3. **CORS errors:**
   - Go to Settings > Middlewares
   - Ensure CORS is enabled
   - Add your domain to allowed origins if needed

4. **API token not working:**
   - Verify the token is copied correctly
   - Check if the token has the right permissions
   - Ensure the token hasn't expired

### Debug Tips

1. **Check Strapi Logs:**
   - Look at the terminal where Strapi is running
   - Check for any error messages

2. **Test API Directly:**
   - Use browser or tools like Postman to test API endpoints
   - Verify the response format matches your Next.js expectations

3. **Check Network Tab:**
   - Open browser developer tools
   - Check the Network tab for failed requests
   - Look for CORS or authentication errors

## 📚 Next Steps

Once your basic setup is working:

1. **Add Media Support:**
   - Enable Media Library in Strapi
   - Add image fields to your content types
   - Update Next.js to handle images

2. **Add More Fields:**
   - Date fields for publication dates
   - Rich text fields for formatted content
   - Boolean fields for feature flags

3. **Implement SEO:**
   - Add meta description fields
   - Implement dynamic meta tags
   - Add structured data

4. **Set Up Webhooks:**
   - Configure webhooks to trigger rebuilds automatically
   - Integrate with deployment services

## 🆘 Getting Help

If you encounter issues:

1. **Check Strapi Documentation:** https://docs.strapi.io/
2. **Check Next.js Documentation:** https://nextjs.org/docs
3. **Verify your setup matches this guide exactly**
4. **Check the browser console for JavaScript errors**
5. **Check the Strapi server logs for backend errors**

Remember: The key to success is ensuring your Strapi content is published (not just saved as draft) and that the API permissions are correctly configured for public access.
