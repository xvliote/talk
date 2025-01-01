class TTSService {
  private readonly API_URL = '/api/tts';

  async synthesize(text: string, lang: string = 'en-US'): Promise<ArrayBuffer> {
    try {
      console.log('Sending TTS request:', { text, lang });
      const response = await fetch(this.API_URL, {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
        },
        body: JSON.stringify({ text, lang })
      });

      if (!response.ok) {
        const errorText = await response.text();
        console.error('TTS API Error:', {
          status: response.status,
          statusText: response.statusText,
          errorText
        });
        throw new Error(`Failed to synthesize speech: ${response.status} ${response.statusText}`);
      }

      const contentType = response.headers.get('Content-Type');
      console.log('TTS response received:', { contentType });
      
      if (!contentType?.includes('audio/')) {
        const errorText = await response.text();
        console.error('Invalid content type:', { contentType, errorText });
        throw new Error('Invalid response from TTS service');
      }

      const buffer = await response.arrayBuffer();
      console.log('Audio buffer received, size:', buffer.byteLength);
      return buffer;
    } catch (error) {
      console.error('TTS Error:', error);
      throw error;
    }
  }

  async playText(text: string, lang: string = 'en-US'): Promise<void> {
    try {
      console.log('Starting TTS playback:', { text, lang });
      const audioContent = await this.synthesize(text, lang);
      
      console.log('Creating audio blob...');
      const blob = new Blob([audioContent], { type: 'audio/mp3' });
      const url = URL.createObjectURL(blob);
      const audio = new Audio(url);
      
      return new Promise((resolve, reject) => {
        audio.oncanplay = () => {
          console.log('Audio ready to play');
        };
        
        audio.onplay = () => {
          console.log('Audio playback started');
        };
        
        audio.onended = () => {
          console.log('Audio playback completed');
          URL.revokeObjectURL(url);
          resolve();
        };
        
        audio.onerror = (e) => {
          console.error('Audio playback error:', e);
          URL.revokeObjectURL(url);
          reject(new Error('Failed to play audio'));
        };
        
        console.log('Starting audio playback...');
        audio.play().catch((error) => {
          console.error('Audio play error:', error);
          URL.revokeObjectURL(url);
          reject(error);
        });
      });
    } catch (error) {
      console.error('Play TTS Error:', error);
      throw error;
    }
  }
}

// 创建单例实例
export const ttsService = new TTSService();
