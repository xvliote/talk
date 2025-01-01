import { defineConfig } from 'vite'
import react from '@vitejs/plugin-react'

export default defineConfig({
  plugins: [react()],
  server: {
    port: 3002,
    proxy: {
      '/api/tts': {
        target: 'http://localhost:3000',
        changeOrigin: true
      }
    }
  }
})
