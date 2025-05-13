enum Environment {
  dev,
  staging,
  prod,
}

class EnvConfig {
  static Environment environment = Environment.dev;
  
  static String get baseUrl {
    switch (environment) {
      case Environment.dev:
        return 'http://localhost:3000';
      case Environment.staging:
        return 'https://staging-api.perfectweddingplanner.com';
      case Environment.prod:
        return 'https://api.perfectweddingplanner.com';
    }
  }
  
  static bool get isDevelopment => environment == Environment.dev;
  static bool get isStaging => environment == Environment.staging;
  static bool get isProduction => environment == Environment.prod;
} 