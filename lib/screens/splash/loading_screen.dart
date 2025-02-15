import 'package:flutter/material.dart';
import 'package:povedi_me_app/constants/styles/app_colors.dart';

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(
          color: AppColors.yellow,
        ),
      ),
      backgroundColor: AppColors.lightBlue,
    );
  }
}
