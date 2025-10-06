import { GetStaticProps } from 'next'
import Head from 'next/head'
import { fetchHomepageContent, HomepageContent } from '../lib/strapi'

interface HomeProps {
  content: HomepageContent | null
}

export default function Home({ content }: HomeProps) {
  return (
    <>
      <Head>
        <title>Next.js + Strapi Static Site</title>
        <meta name="description" content="A static site generated with Next.js and Strapi" />
        <meta name="viewport" content="width=device-width, initial-scale=1" />
        <link rel="icon" href="/favicon.ico" />
      </Head>
      
      <main style={{
        minHeight: '100vh',
        display: 'flex',
        flexDirection: 'column',
        alignItems: 'center',
        justifyContent: 'center',
        padding: '2rem',
        fontFamily: 'system-ui, sans-serif',
        backgroundColor: '#f8fafc',
        color: '#1e293b'
      }}>
        <div style={{
          maxWidth: '800px',
          textAlign: 'center',
          backgroundColor: 'white',
          padding: '3rem',
          borderRadius: '12px',
          boxShadow: '0 4px 6px -1px rgb(0 0 0 / 0.1)',
        }}>
          <h1 style={{
            fontSize: '2.5rem',
            fontWeight: 'bold',
            marginBottom: '1rem',
            color: '#1e293b'
          }}>
            {content?.title || 'Hello World!'}
          </h1>
          
          <p style={{
            fontSize: '1.25rem',
            lineHeight: '1.6',
            color: '#64748b',
            marginBottom: '2rem'
          }}>
            {content?.content || 'This is a static site generated with Next.js and powered by Strapi CMS.'}
          </p>
          
          <div style={{
            padding: '1rem',
            backgroundColor: '#f1f5f9',
            borderRadius: '8px',
            fontSize: '0.875rem',
            color: '#64748b'
          }}>
            <p><strong>Last updated:</strong> {content?.updatedAt ? new Date(content.updatedAt).toLocaleString() : 'Never'}</p>
            <p><strong>Content ID:</strong> {content?.id || 'N/A'}</p>
          </div>
        </div>
      </main>
    </>
  )
}

export const getStaticProps: GetStaticProps = async () => {
  try {
    const content = await fetchHomepageContent()
    
    return {
      props: {
        content,
      },
    }
  } catch (error) {
    console.error('Error in getStaticProps:', error)
    
    return {
      props: {
        content: null,
      },
    }
  }
}
