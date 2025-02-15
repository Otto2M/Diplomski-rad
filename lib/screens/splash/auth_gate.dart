import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:povedi_me_app/assets.dart';
import 'package:povedi_me_app/constants/styles/app_colors.dart';

import 'package:povedi_me_app/providers/auth_user_state_provider.dart';
import 'package:povedi_me_app/providers/categories_provider.dart';
import 'package:povedi_me_app/providers/onboarding_status_provider.dart';
import 'package:povedi_me_app/screens/splash/loading_screen.dart';

import 'package:povedi_me_app/screens/splash/onboarding_screen.dart';
import 'package:povedi_me_app/screens/splash/welcome_screen.dart';
import 'package:povedi_me_app/widgets/tab_screen.dart';

class AuthGate extends ConsumerStatefulWidget {
  const AuthGate({super.key});

  @override
  ConsumerState<AuthGate> createState() => _AuthGateState();
}

class _AuthGateState extends ConsumerState<AuthGate> {
  bool _showSplash = true;

  @override
  void initState() {
    super.initState();

    ref.read(categoriesProvider.future);
    ref.read(subcategoriesProvider.future);

    Timer(const Duration(seconds: 3), () {
      setState(() {
        _showSplash = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_showSplash) {
      return Scaffold(
        backgroundColor: AppColors.lightBlue,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(Assets.logo),
              Image.asset(
                Assets.povediMeTxt,
                fit: BoxFit.contain,
                scale: 6,
              ),
            ],
          ),
        ),
      );
    }

    final authStateAsync = ref.watch(authStateProvider);
    return authStateAsync.when(
      data: (User? user) {
        if (user != null) {
          return const TabScreen();
        } else {
          final onboardingAsync = ref.watch(onboardingStatusProvider);
          return onboardingAsync.when(
            data: (bool isOnboardingSeen) {
              if (!isOnboardingSeen) {
                return const OnboardingScreen();
              } else {
                return const WelcomeScreen();
              }
            },
            loading: () => const Scaffold(
              body: Center(child: LoadingScreen()),
            ),
            error: (error, stack) => Scaffold(
              body: Center(child: Text('Došlo je do pogreške: $error')),
            ),
          );
        }
      },
      loading: () => const Scaffold(
        body: Center(child: LoadingScreen()),
      ),
      error: (error, stack) => Scaffold(
        body: Center(child: Text('Došlo je do pogreške: $error')),
      ),
    );
  }
}
