import 'dart:async';
import 'package:flutter/material.dart';

import 'package:povedi_me_app/assets.dart';
import 'package:povedi_me_app/constants/styles/text.dart';
import 'package:povedi_me_app/widgets/tab_screen.dart';

class RegistrationScreenSuccess extends StatefulWidget {
  const RegistrationScreenSuccess({super.key});

  @override
  State<RegistrationScreenSuccess> createState() =>
      _RegistrationScreenSuccessState();
}

class _RegistrationScreenSuccessState extends State<RegistrationScreenSuccess> {
  @override
  void initState() {
    Timer(
        const Duration(seconds: 3),
        () => Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) => const TabScreen(),
              ),
            ));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Text(
                "Registracija uspješna!".toUpperCase(),
                softWrap: true,
                textAlign: TextAlign.center,
                style: AppTextStyles.reviewMessage(context),
              ),
            ),
            const SizedBox(height: 20),
            Image.asset(
              Assets.iCorrect,
              color: Theme.of(context).textTheme.bodyMedium!.color,
              scale: 8,
            ),
          ],
        ),
      ),
    );
  }
}
