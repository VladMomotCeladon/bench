import { config } from '../config'
import fs from 'fs'
import path from 'path'

export interface StrapiResponse<T> {
  data: T
  meta: {
    pagination?: {
      page: number
      pageSize: number
      pageCount: number
      total: number
    }
  }
}

export interface HomepageContent {
  id: number
  documentId: string
  title: string
  content: string
  createdAt: string
  updatedAt: string
  publishedAt: string
}

export async function fetchHomepageContent(): Promise<HomepageContent | null> {
  try {
    // First, try to read from pre-fetched content.json file
    const contentPath = path.join(process.cwd(), 'content.json')
    if (fs.existsSync(contentPath)) {
      try {
        const contentData = JSON.parse(fs.readFileSync(contentPath, 'utf8'))
        if (contentData && contentData.data && Array.isArray(contentData.data) && contentData.data.length > 0) {
          // Sort by publishedAt date (most recent first) and return the latest
          const sortedData = contentData.data.sort((a: HomepageContent, b: HomepageContent) => 
            new Date(b.publishedAt).getTime() - new Date(a.publishedAt).getTime()
          )
          console.log('✅ Using pre-fetched content from content.json')
          return sortedData[0]
        }
      } catch (fileError) {
        console.log('⚠️ Could not read content.json, falling back to live fetch')
      }
    }

    // Fallback to live fetching if content.json doesn't exist or is invalid
    console.log('📡 Attempting live fetch from Strapi...')
    const urls = [
      `${config.strapiUrl}/api/homepage-contents?populate=*`,
      `http://127.0.0.1:1337/api/homepage-contents?populate=*`,
      `http://localhost:1337/api/homepage-contents?populate=*`
    ]
    
    for (const url of urls) {
      try {
        const response = await fetch(url, {
          headers: {
            'Authorization': `Bearer ${config.apiToken}`,
            'Content-Type': 'application/json',
          },
          // Add timeout and retry logic
          signal: AbortSignal.timeout(10000) // Increased timeout
        })

        if (response.ok) {
          const data = await response.json() as StrapiResponse<HomepageContent[]>
          console.log('✅ Successfully fetched content from:', url)
          // Sort by publishedAt date (most recent first) and return the latest
          const sortedData = data.data?.sort((a, b) => 
            new Date(b.publishedAt).getTime() - new Date(a.publishedAt).getTime()
          )
          return sortedData?.[0] || null
        }
      } catch (urlError) {
        console.log(`❌ Failed to fetch from ${url}:`, (urlError as Error).message)
        continue
      }
    }
    
    // If all attempts fail, return null instead of throwing error
    console.log('⚠️ Could not fetch content from Strapi, using fallback content')
    return null
  } catch (error) {
    console.error('Error fetching homepage content:', error)
    return null
  }
}
