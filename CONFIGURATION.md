# Configuration Guide

## Environment Variables

Create a `.env.local` file in the root directory with the following content:

```env
# Strapi Configuration
NEXT_PUBLIC_STRAPI_URL=http://localhost:1337
STRAPI_API_TOKEN=your_strapi_api_token_here
```

## Quick Start Commands

### 1. Complete Project Setup
```bash
./setup-project.sh
```

### 2. Start Strapi Backend
```bash
cd strapi-backend
npm run develop
```

### 3. Start Next.js Frontend
```bash
npm run dev
```

### 4. Rebuild Static Site
```bash
./rebuild.sh
```

## What's Already Configured

✅ **Strapi Content Type**: "Homepage Content" with title and content fields
✅ **API Permissions**: Public access enabled for homepage content
✅ **Initial Data**: Sample content already created
✅ **Bootstrap Script**: Automatically sets up permissions and data on first run
✅ **Next.js Integration**: Ready to fetch from Strapi API

## API Endpoints

- **Strapi Admin**: http://localhost:1337/admin
- **Homepage Content API**: http://localhost:1337/api/homepage-contents
- **Next.js Site**: http://localhost:3000 (after running `npm run dev`)

## Workflow

1. **Edit content** in Strapi admin panel
2. **Run `./rebuild.sh`** to rebuild the static site
3. **Deploy** the `out` directory to your hosting provider
