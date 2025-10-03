import { config } from '../config'

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
    // Try multiple URLs to handle connection issues
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
          signal: AbortSignal.timeout(5000)
        })

        if (response.ok) {
          const data: StrapiResponse<HomepageContent[]> = await response.json()
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
    
    throw new Error('All connection attempts failed')
  } catch (error) {
    console.error('Error fetching homepage content:', error)
    return null
  }
}
