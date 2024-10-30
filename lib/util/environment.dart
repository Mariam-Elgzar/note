import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class Environment {
  static String get fileName {
    if (kReleaseMode) {
      return '.env.production';
    } else {
      return '.env.development';
    }
  }

  static String get baseUrl {
    return dotenv.env['BASE_URL'] ?? '';
  }
  
  static String get serverSha256Fingerprint {
    return dotenv.env['SERVER_SHA256_FINGERPRINT'] ?? '';
  }
}
