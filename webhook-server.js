const express = require('express');
const { exec } = require('child_process');
const path = require('path');

const app = express();
const PORT = 3001;

// Middleware to parse JSON
app.use(express.json());

// Webhook endpoint
app.post('/webhook/rebuild', (req, res) => {
  console.log('🚀 Webhook triggered! Rebuilding site...');
  
  // Execute the rebuild script
  const projectPath = __dirname;
  const rebuildCommand = `cd ${projectPath} && ./rebuild.sh`;
  
  exec(rebuildCommand, (error, stdout, stderr) => {
    if (error) {
      console.error('❌ Rebuild failed:', error);
      return res.status(500).json({ 
        success: false, 
        error: error.message,
        stderr: stderr 
      });
    }
    
    console.log('✅ Rebuild completed successfully!');
    console.log('📝 Output:', stdout);
    
    res.json({ 
      success: true, 
      message: 'Site rebuilt successfully',
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
