interface AppConfig {
  // 其他服务的配置
  groq?: {
    apiKey: string;
  };
  gemini?: {
    apiKey: string;
  };
}

export const config: AppConfig = {
  groq: {
    apiKey: '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'
  },
  gemini: {
    apiKey: 'AIzaSyDJSovgdPVXI-zRUA43dCIXu-F18UaA4V4'
  }
}

