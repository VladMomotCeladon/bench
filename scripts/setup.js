const { execSync } = require('child_process');
const fs = require('fs');
const path = require('path');

console.log('🚀 Setting up Strapi for Next.js integration...');

// Function to run Strapi CLI commands
function runStrapiCommand(command) {
  try {
    console.log(`Running: ${command}`);
    execSync(command, { stdio: 'inherit', cwd: __dirname });
  } catch (error) {
    console.error(`Error running command: ${command}`, error.message);
  }
}

// Function to create initial data
function createInitialData() {
  const dataPath = path.join(__dirname, 'initial-data.json');
  const initialData = {
    title: "Hello World!",
    content: "This is a static site generated with Next.js and powered by Strapi CMS. You can edit this content in Strapi and rebuild the site to see changes."
  };
  
  fs.writeFileSync(dataPath, JSON.stringify(initialData, null, 2));
  console.log('✅ Initial data file created');
}

// Create initial data file
createInitialData();

console.log(`
🎉 Strapi setup complete!

Next steps:
1. Start Strapi: npm run develop
2. Go to http://localhost:1337/admin
3. Create your admin account
4. Go to Settings > Roles > Public
5. Enable "find" permission for "Homepage Content"
6. Go to Content Manager and create your first homepage content entry

The initial data is saved in: ${path.join(__dirname, 'initial-data.json')}
`);
