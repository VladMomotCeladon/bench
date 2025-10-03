# Next.js + Strapi Static Site Generator

A simple static website built with Next.js that fetches content from Strapi CMS. The site uses Static Site Generation (SSG) and can be rebuilt with a single command to reflect content changes from Strapi.

## 🚀 Quick Start

### 1. Install Dependencies
```bash
npm install
```

### 2. Set up Environment Variables
Create a `.env.local` file in the root directory:
```env
NEXT_PUBLIC_STRAPI_URL=http://localhost:1337
STRAPI_API_TOKEN=your_strapi_api_token_here
```

### 3. Run Development Server
```bash
npm run dev
```

### 4. Build Static Site
```bash
npm run build
```

### 5. Rebuild with One Click
```bash
./rebuild.sh
```

## 📋 Strapi Setup Instructions

### Step 1: Install and Start Strapi

1. **Create a new Strapi project:**
   ```bash
   npx create-strapi-app@latest my-strapi-project --quickstart
   cd my-strapi-project
   ```

2. **Start Strapi:**
   ```bash
   npm run develop
   ```

3. **Access Strapi Admin Panel:**
   - Open http://localhost:1337/admin
   - Create your admin account

### Step 2: Create Content Type

1. **Go to Content-Type Builder:**
   - In the Strapi admin panel, click "Content-Type Builder" in the left sidebar

2. **Create a new Collection Type:**
   - Click "Create new collection type"
   - Name it: `Homepage Content`
   - API ID will be: `homepage-content`

3. **Add Fields:**
   - **Title** (Text, Short text)
     - Field name: `title`
     - Required: Yes
   - **Content** (Text, Long text)
     - Field name: `content`
     - Required: Yes

4. **Save the Content Type:**
   - Click "Save" in the top right

### Step 3: Configure API Permissions

1. **Go to Settings > Roles:**
   - Click "Public" role
   - Under "Homepage Content", check "find" permission
   - Click "Save"

2. **Create API Token (Optional but Recommended):**
   - Go to Settings > API Tokens
   - Click "Create new API Token"
   - Name: `Next.js Static Site`
   - Token type: `Read-only`
   - Click "Save"
   - Copy the generated token and add it to your `.env.local` file

### Step 4: Add Content

1. **Go to Content Manager:**
   - Click "Content Manager" in the left sidebar
   - Click "Homepage Content"
   - Click "Create new entry"

2. **Fill in the content:**
   - **Title:** `Hello World!`
   - **Content:** `This is a static site generated with Next.js and powered by Strapi CMS.`

3. **Publish the content:**
   - Click "Save" then "Publish"

## 🔄 How the Rebuild Process Works

### Automatic Rebuild
The site uses Next.js Static Site Generation with the following features:

1. **Build Time Data Fetching:**
   - Content is fetched from Strapi during build time
   - Static HTML files are generated
   - No server required for hosting

2. **Revalidation:**
   - The site revalidates content every hour (3600 seconds)
   - You can trigger immediate rebuilds manually

### Manual Rebuild Process

1. **Update content in Strapi:**
   - Go to Strapi admin panel
   - Edit your homepage content
   - Save and publish changes

2. **Rebuild the static site:**
   ```bash
   ./rebuild.sh
   ```
   This script will:
   - Install dependencies if needed
   - Build the static site
   - Generate files in the `out` directory

3. **Deploy the updated site:**
   - Upload the contents of the `out` directory to your hosting provider
   - Or serve locally with: `npx serve out`

## 📁 Project Structure

```
├── pages/
│   ├── index.tsx          # Main homepage with SSG
│   └── _app.tsx           # App wrapper
├── lib/
│   └── strapi.ts          # Strapi API integration
├── styles/
│   └── globals.css        # Global styles
├── config.ts              # Configuration
├── next.config.js         # Next.js configuration
├── package.json           # Dependencies
├── rebuild.sh             # One-click rebuild script
└── README.md              # This file
```

## 🛠️ Configuration Options

### Environment Variables

- `NEXT_PUBLIC_STRAPI_URL`: Your Strapi server URL (default: http://localhost:1337)
- `STRAPI_API_TOKEN`: API token for authenticated requests (optional)

### Next.js Configuration

The `next.config.js` file is configured for static export:
- `output: 'export'` - Generates static files
- `trailingSlash: true` - Adds trailing slashes to URLs
- `images: { unoptimized: true }` - Disables image optimization for static export

## 🚀 Deployment

### Static Hosting Providers

The generated `out` directory can be deployed to any static hosting provider:

- **Vercel:** `vercel --prod`
- **Netlify:** Drag and drop the `out` folder
- **GitHub Pages:** Push the `out` folder contents
- **AWS S3:** Upload the `out` folder contents

### Automated Deployment

You can set up automated deployments that trigger rebuilds when Strapi content changes:

1. **Webhook Integration:**
   - Set up a webhook in Strapi that calls your deployment service
   - Configure your hosting provider to rebuild on webhook triggers

2. **Scheduled Rebuilds:**
   - Use GitHub Actions, Vercel Cron, or similar services
   - Schedule regular rebuilds to pick up content changes

## 🔧 Troubleshooting

### Common Issues

1. **Content not updating:**
   - Check if Strapi is running on the correct port
   - Verify API permissions are set correctly
   - Ensure the API token is valid (if using one)

2. **Build failures:**
   - Check Strapi server connectivity
   - Verify environment variables are set correctly
   - Check the browser console for API errors

3. **CORS issues:**
   - Configure CORS in Strapi settings
   - Add your domain to allowed origins

### Debug Mode

To debug API calls, check the browser's Network tab or add console logs in the `lib/strapi.ts` file.

## 📝 Customization

### Adding More Content Types

1. Create new content types in Strapi
2. Add corresponding interfaces in `lib/strapi.ts`
3. Create new API functions
4. Use them in your pages with `getStaticProps`

### Styling

The site uses inline styles for simplicity. You can:
- Replace with CSS modules
- Use a CSS framework like Tailwind
- Add a design system

### Advanced Features

- Add image support with Strapi Media Library
- Implement multiple pages with different content types
- Add SEO metadata from Strapi
- Implement content preview functionality

## 📞 Support

If you encounter any issues:
1. Check the Strapi documentation
2. Verify your Next.js configuration
3. Check the browser console for errors
4. Ensure all environment variables are set correctly
