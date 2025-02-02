import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:povedi_me_app/constants/styles/text.dart';

import 'package:povedi_me_app/providers/onboarding_status_provider.dart';
import 'package:povedi_me_app/screens/splash/onboarding_screen.dart';
import 'package:povedi_me_app/widgets/tab_screen.dart';

class InitialScreen extends ConsumerWidget {
  const InitialScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final onboardingStatus = ref.watch(onboardingStatusProvider);

    return onboardingStatus.when(
      data: (isOnboardingSeen) {
        return isOnboardingSeen ? const TabScreen() : const OnboardingScreen();
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (err, stack) => Center(
        child: Text(
          'Greška prilikom dohvaćanja statusa: $err',
          style: AppTextStyles.errorText(context),
        ),
      ),
    );
  }
}
