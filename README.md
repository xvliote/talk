# IELTSTalk

A web application designed to help IELTS test takers practice speaking using advanced text-to-speech technology powered by PlayHT API.

## Features
- Text-to-speech conversion with natural-sounding voices
- Speaking practice with IELTS-style questions
- Voice recording and playback for self-assessment
- Modern and intuitive user interface
- Progress tracking and history
- Offline support with local storage
- Multi-language support
- HTTPS secure access
- Request logging and monitoring

## Prerequisites

### Required Software
- Node.js 18 or higher
- pnpm 8 or higher
- Nginx 1.18 or higher (for production deployment)
- SSL certificate (for HTTPS support)

### Dependencies Versions
- React 18.2.0
- TypeScript 5.0.0
- Vite 5.0.0
- Express 4.18.2
- TailwindCSS 3.4.0
- React Query 5.0.0
- Zustand 4.0.0
- Google Cloud Text-to-Speech 5.0.1

## Installation

1. Clone the repository:
```bash
git clone <repository-url>
cd ieltstalk
```

2. Install dependencies:
```bash
pnpm install
```

3. Set up environment variables:
Create a `.env` file in the root directory with the following content:
```env
PLAYHT_API_KEY=your_api_key
PLAYHT_USER_ID=your_user_id
```

## Development

Start the development server:
```bash
pnpm dev
```

The application will be available at http://localhost:3002

## API Endpoints

The server provides the following API endpoints:

### POST /api/tts
Text-to-speech conversion endpoint
- Request body: 
  ```json
  {
    "text": "Text to convert to speech",
    "lang": "Language code (e.g., en-US, zh-CN)"
  }
  ```
- Response: Audio file in MP3 format

## Production Deployment

### System Requirements
- Linux server (Ubuntu/CentOS recommended)
- Minimum 1GB RAM
- 10GB disk space
- Domain name with DNS configured

### Build
```bash
pnpm build
```

### Nginx Configuration
Create or modify your Nginx configuration (e.g., `/etc/nginx/conf.d/ieltstalk.conf`):

```nginx
# HTTP - Redirect all traffic to HTTPS
server {
    listen 80;
    server_name your.domain.com;

    location / {
        proxy_pass http://localhost:3000;
        proxy_http_version 1.1;
        proxy_set_header Upgrade $http_upgrade;
        proxy_set_header Connection 'upgrade';
        proxy_set_header Host $host;
        proxy_cache_bypass $http_upgrade;
    }
}

# HTTPS
server {
    listen 443 ssl;
    server_name your.domain.com;

    ssl_certificate /path/to/your/fullchain.pem;
    ssl_certificate_key /path/to/your/privkey.pem;

    location / {
        proxy_pass http://localhost:3000;
        proxy_http_version 1.1;
        proxy_set_header Upgrade $http_upgrade;
        proxy_set_header Connection 'upgrade';
        proxy_set_header Host $host;
        proxy_cache_bypass $http_upgrade;
    }
}
```

Replace:
- `your.domain.com` with your actual domain
- `/path/to/your/fullchain.pem` with your SSL certificate path
- `/path/to/your/privkey.pem` with your SSL private key path

After updating the Nginx configuration:
```bash
# Test Nginx configuration
sudo nginx -t

# Restart Nginx to apply changes
sudo systemctl restart nginx
```

### Start Production Server
```bash
pnpm start
```

The application will run on port 3000 by default, and Nginx will proxy requests to it.

### Server Management Scripts

#### restart.sh
Restarts the application server:
```bash
./restart.sh
```
This script will:
1. Rebuild the project
2. Stop any existing Node.js process
3. Start a new server instance
4. Verify the server is running

#### stop.sh
Stops the application server:
```bash
./stop.sh
```

## Project Structure
```
ieltstalk/
├── src/                    # Source code
│   ├── components/         # React components
│   │   ├── AudioVisualizer.tsx    # Audio visualization
│   │   ├── PromptEditor.tsx       # Text input component
│   │   └── RecordingHistory.tsx   # History display
│   ├── lib/               # Utility functions and APIs
│   │   ├── api.ts         # API client
│   │   ├── db.ts          # Database operations
│   │   ├── recorder.ts    # Audio recording
│   │   └── tts.ts         # Text-to-speech
│   └── config/            # Configuration files
├── server.js              # Express server
├── nginx.conf            # Nginx configuration
└── scripts/              # Management scripts
```

## Logging and Monitoring

The application logs are stored in:
- Server logs: `server.log`
- Nginx access logs: `/var/log/nginx/access.log`
- Nginx error logs: `/var/log/nginx/error.log`

## Security Considerations

1. API Keys and Credentials
   - Store sensitive credentials in `.env` file
   - Never commit credentials to version control
   - Use environment variables in production

2. CORS Configuration
   - Production should limit `origin` to specific domains
   - Currently configured in `server.js`

3. SSL/TLS
   - Always use HTTPS in production
   - Keep certificates up to date
   - Configure secure SSL parameters in Nginx

## Contributing
Contributions are welcome! Please feel free to submit a Pull Request.

## License
MIT License
