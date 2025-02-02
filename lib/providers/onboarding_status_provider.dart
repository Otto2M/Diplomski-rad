import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Provider koji dohvaća i pohranjuje status
final onboardingStatusProvider = FutureProvider<bool>((ref) async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getBool('onboarding_seen') ?? false;
});

// Provider za ažuriranje statusa kada korisnik završi onboarding
final onboardingUpdaterProvider = Provider<OnboardingUpdater>((ref) {
  return OnboardingUpdater(ref);
});

class OnboardingUpdater {
  final Ref ref;

  OnboardingUpdater(this.ref);

  Future<void> markOnboardingAsSeen() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('onboarding_seen', true);

    // Ponovno učitavanje statusa u provideru
    ref.invalidate(onboardingStatusProvider);
  }
}
