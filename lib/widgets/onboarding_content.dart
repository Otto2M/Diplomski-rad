import 'package:flutter/material.dart';
import 'package:povedi_me_app/constants/styles/text.dart';

class OnboardingContent extends StatelessWidget {
  const OnboardingContent({
    super.key,
    required this.title,
    required this.description,
    required this.image,
  });

  final String title, description, image;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(image, height: 300),
        const SizedBox(height: 20),
        Text(
          title,
          style: AppTextStyles.onBordScrTitle(context),
        ),
        const SizedBox(height: 20),
        Text(
          description,
          textAlign: TextAlign.center,
          softWrap: true,
          style: AppTextStyles.onBordScrDesc(context),
        ),
      ],
    );
  }
}
