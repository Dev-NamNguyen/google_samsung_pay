import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class Environment {
  static String get fileName {
    if (kReleaseMode) {
      print("✅ Running in release mode");
      return ".env.develop";
    }

    if (kProfileMode) {
      print("✅ Running in profile mode");
      return ".env.develop";
    }

    print("✅ Running in debug mode");
    return ".env.develop";
  }

  // static String get apiKey {
  //   return dotenv.env['API_KEY'] ?? '';
  // }

  static String get apiBaseURL {
    print("🚀✅ Environment.apiBaseURL: ${dotenv.env['LOCAL_API']}");
    return dotenv.env['LOCAL_API'] ?? 'BASE_API not specified';
  }

  static String get apiLocalURL {
    print("🚀 Environment.apiLocalURL: ${dotenv.env['LOCAL_API']}");
    return dotenv.env['LOCAL_API'] ?? 'LOCAL_API not specified';
  }
}
