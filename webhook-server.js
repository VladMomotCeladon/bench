const express = require('express');
const { exec } = require('child_process');
const path = require('path');

const app = express();
const PORT = 3001;

// Middleware to parse JSON
app.use(express.json());

// Webhook endpoint
app.post('/webhook/rebuild', (req, res) => {
  console.log('🚀 Webhook triggered! Deploying from GitHub to Firebase...');
  
  // Execute the Firebase deployment script
  const projectPath = __dirname;
  const deployCommand = `cd ${projectPath} && ./deploy-firebase-config.sh`;
  
  exec(deployCommand, (error, stdout, stderr) => {
    if (error) {
      console.error('❌ Firebase deployment failed:', error);
      return res.status(500).json({ 
        success: false, 
        error: error.message,
        stderr: stderr 
      });
    }
    
    console.log('✅ Firebase deployment completed successfully!');
    console.log('📝 Output:', stdout);
    
    res.json({ 
      success: true, 
      message: 'Site deployed to Firebase successfully',
      output: stdout 
    });
  });
});

// Health check endpoint
app.get('/health', (req, res) => {
  res.json({ status: 'OK', timestamp: new Date().toISOString() });
});

// Start the server
app.listen(PORT, () => {
  console.log(`🎯 Webhook server running on http://localhost:${PORT}`);
  console.log(`📡 Webhook endpoint: http://localhost:${PORT}/webhook/rebuild`);
  console.log(`💚 Health check: http://localhost:${PORT}/health`);
});

module.exports = app;
