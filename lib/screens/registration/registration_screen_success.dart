import 'dart:async';

import 'package:flutter/material.dart';
import 'package:povedi_me_app/constants/styles/app_colors.dart';
import 'package:povedi_me_app/screens/home/home_screen.dart';

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
        const Duration(seconds: 2),
        () => Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) => const HomeScreen(),
              ),
            ));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Registracija uspješna!",
              style: TextStyle(
                color: AppColors.accentLight,
                fontSize: 30,
              ),
            ),
            SizedBox(height: 20),
            Icon(
              Icons.check_rounded,
              size: 50,
            ),
          ],
        ),
      ),
    );
  }
}
