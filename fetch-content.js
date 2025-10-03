#!/usr/bin/env node

// Script to fetch content from Strapi and save it as JSON
const https = require('https');
const http = require('http');
const fs = require('fs');

async function fetchContent() {
  return new Promise((resolve) => {
    const options = {
      hostname: '127.0.0.1',
      port: 1337,
      path: '/api/homepage-contents?populate=*',
      method: 'GET',
      headers: {
        'Content-Type': 'application/json',
      }
    };

    const req = http.request(options, (res) => {
      let data = '';
      
      res.on('data', (chunk) => {
        data += chunk;
      });
      
      res.on('end', () => {
        try {
          const jsonData = JSON.parse(data);
          fs.writeFileSync('content.json', JSON.stringify(jsonData, null, 2));
          console.log('✅ Content fetched and saved to content.json');
          resolve(jsonData);
        } catch (error) {
          console.log('❌ Could not parse response:', error.message);
          createFallbackContent();
          resolve(null);
        }
      });
    });

    req.on('error', (error) => {
      console.log('❌ Could not fetch content:', error.message);
      createFallbackContent();
      resolve(null);
    });

    req.setTimeout(5000, () => {
      console.log('❌ Request timeout');
      createFallbackContent();
      resolve(null);
    });

    req.end();
  });
}

function createFallbackContent() {
  const fallbackContent = {
    data: [{
      id: 1,
      documentId: "fallback",
      title: "Hello World!",
      content: "This is a static site generated with Next.js and powered by Strapi CMS.",
      createdAt: new Date().toISOString(),
      updatedAt: new Date().toISOString(),
      publishedAt: new Date().toISOString()
    }],
    meta: { pagination: { page: 1, pageSize: 25, pageCount: 1, total: 1 } }
  };
  
  fs.writeFileSync('content.json', JSON.stringify(fallbackContent, null, 2));
  console.log('⚠️ Using fallback content');
}

fetchContent();
