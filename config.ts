// Configuration for Strapi integration
export const config = {
  strapiUrl: process.env.NEXT_PUBLIC_STRAPI_URL || 'http://127.0.0.1:1337',
  apiToken: process.env.STRAPI_API_TOKEN || '',
}
