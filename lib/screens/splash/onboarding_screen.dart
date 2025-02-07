//
//
//za odabir jezika i objasnjena nekih dijelova aplikacije
//
//

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:povedi_me_app/constants/styles/app_colors.dart';
import 'package:povedi_me_app/constants/styles/text.dart';
import 'package:povedi_me_app/data/onboarding_data.dart';
import 'package:povedi_me_app/providers/onboarding_status_provider.dart';
import 'package:povedi_me_app/widgets/onboarding_content.dart';
import 'welcome_screen.dart';

class OnboardingScreen extends ConsumerStatefulWidget {
  const OnboardingScreen({super.key});

  @override
  ConsumerState<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends ConsumerState<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  Future<void> _completeOnboarding() async {
    await ref.read(onboardingUpdaterProvider).markOnboardingAsSeen();
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => const WelcomeScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightBlue,
      body: PageView.builder(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            _currentPage = index;
          });
        },
        itemCount: onboardingData.length,
        itemBuilder: (context, index) => OnboardingContent(
          title: onboardingData[index]["title"]!,
          description: onboardingData[index]["description"]!,
          image: onboardingData[index]["image"]!,
        ),
      ),
      bottomSheet: _currentPage == onboardingData.length - 1
          ? TextButton(
              onPressed: _completeOnboarding,
              child: Text(
                "Kreni dalje",
                style: AppTextStyles.onBordScrInputBtnRowNav(context),
              ),
            )
          : Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: () => _pageController.jumpToPage(3),
                  child: Text(
                    "Preskoči",
                    style: AppTextStyles.onBordScrInputBtnRowNav(context),
                  ),
                ),
                Row(
                  children: List.generate(
                    onboardingData.length,
                    (index) => buildDot(index, context),
                  ),
                ),
                TextButton(
                  onPressed: () => _pageController.nextPage(
                    duration: const Duration(milliseconds: 200),
                    curve: Curves.ease,
                  ),
                  child: Text(
                    "Dalje",
                    style: AppTextStyles.onBordScrInputBtnRowNav(context),
                  ),
                ),
              ],
            ),
    );
  }

  Widget buildDot(int index, BuildContext context) {
    return Container(
      height: 10,
      width: _currentPage == index ? 20 : 10,
      margin: const EdgeInsets.symmetric(horizontal: 5),
      decoration: BoxDecoration(
        color: _currentPage == index ? AppColors.lightBlue : Colors.grey,
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }
}
