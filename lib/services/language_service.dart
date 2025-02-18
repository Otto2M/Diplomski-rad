import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LanguageService {
  static const String languageKey = 'selectedLanguage';

  Future<void> saveLanguage(String languageCode) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(languageKey, languageCode);
  }

  Future<String> getLanguage() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(languageKey) ?? 'hr';
  }
}

// Riverpod provider za upravljanje jezikom
final languageProvider = StateNotifierProvider<LanguageNotifier, String>((ref) {
  return LanguageNotifier();
});

class LanguageNotifier extends StateNotifier<String> {
  LanguageNotifier() : super('hr') {
    _loadLanguage();
  }

  Future<void> _loadLanguage() async {
    final savedLanguage = await LanguageService().getLanguage();
    state = savedLanguage;
  }

  Future<void> setLanguage(String langCode) async {
    await LanguageService().saveLanguage(langCode);
    state = langCode;
  }
}
