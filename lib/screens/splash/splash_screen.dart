import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:povedi_me_app/assets.dart';
import 'package:povedi_me_app/constants/styles/app_colors.dart';
import 'package:povedi_me_app/constants/styles/text.dart';
import 'package:povedi_me_app/providers/auth_user_state_provider.dart';
import 'package:povedi_me_app/providers/onboarding_status_provider.dart';
import 'package:povedi_me_app/screens/splash/onboarding_screen.dart';
import 'package:povedi_me_app/screens/splash/welcome_screen.dart';
import 'package:povedi_me_app/widgets/tab_screen.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(
      const Duration(seconds: 3),
      () async {
        final isOnboardingSeen =
            await ref.read(onboardingStatusProvider.future);
        final authState = ref.read(authStateProvider).value;

        WidgetsBinding.instance.addPostFrameCallback(
          (_) {
            if (authState != null) {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => const TabScreen()),
              );
            } else if (!isOnboardingSeen) {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                    builder: (context) => const OnboardingScreen()),
              );
            } else {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => const WelcomeScreen()),
              );
            }
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightBlue,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              Assets.logo,
            ),
            Text(
              'POVEDI.ME',
              style: AppTextStyles.splashLogoText(context),
            ),
            const SizedBox(height: 50),
            ElevatedButton(
              onPressed: () {},
              // Navigator.pushReplacement(
              //   context,
              //   MaterialPageRoute(
              //       builder: (context) => const OnboardingScreen()),
              // ),
              style:
                  ElevatedButton.styleFrom(backgroundColor: AppColors.yellow),
              child: const Icon(Icons.navigate_next_rounded),
            ),
          ],
        ),
      ),
    );
  }
}
