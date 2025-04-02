import 'package:flutter_dotenv/flutter_dotenv.dart';

class Keys {
  static String get weatherApiKey {
    return dotenv.env['WEATHER_API_KEY']!;
  }

  static String get googleApiKey {
    return dotenv.env['GOOGLE_API_KEY']!;
  }

  static String get iosApiKey {
    return dotenv.env['IOS_API_KEY']!;
  }

  static String get androidApiKey {
    return dotenv.env['ANDROID_API_KEY']!;
  }
}
