# IELTSTalk

A web application designed to help IELTS test takers practice speaking using advanced text-to-speech technology powered by PlayHT API.

## Features
- Text-to-speech conversion with natural-sounding voices
- Speaking practice with IELTS-style questions
- Voice recording and playback for self-assessment
- Modern and intuitive user interface
- Progress tracking and history
- Offline support with local storage

## Prerequisites
- Node.js 18 or higher
- pnpm package manager

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

## Credentials Setup

### Google Cloud Text-to-Speech API
1. Create a service account in Google Cloud Console
2. Download the service account key JSON file
3. Save it as `config/credentials/google-cloud-credentials.json`
4. Make sure not to commit this file to version control

Example structure of the credentials file can be found in `config/credentials/google-cloud-credentials.example.json`

## Development

Start the development server:
```bash
pnpm dev
```

The application will be available at http://localhost:3002

## Production

Build for production:
```bash
pnpm build
```

Start the production server:
```bash
pnpm start
```

## Project Structure
```
ieltstalk/
├── src/                    # Source code
│   ├── components/         # React components
│   ├── lib/               # Utility functions and APIs
│   └── types/             # TypeScript type definitions
├── public/                # Static assets
└── config/                # Configuration files
```

## Tech Stack
- React 18 with TypeScript
- Vite for fast development and building
- Tailwind CSS for styling
- Express.js backend
- PlayHT API for text-to-speech
- Zustand for state management
- Dexie.js for IndexedDB storage
- React Query for data fetching

## Scripts
- `pnpm dev` - Start development server
- `pnpm build` - Build for production
- `pnpm preview` - Preview production build locally
- `pnpm start` - Start production server

## Contributing
Contributions are welcome! Please feel free to submit a Pull Request.

## License
MIT License
