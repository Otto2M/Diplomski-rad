//prijava ili registracija

import 'package:flutter/material.dart';
import 'package:povedi_me_app/constants/styles/app_colors.dart';
import 'package:povedi_me_app/screens/login/login_screen.dart';
import 'package:povedi_me_app/screens/registration/registration_screen.dart';
import 'package:povedi_me_app/widgets/tab_screen.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightBlue,
      body: Center(
        child: LayoutBuilder(
          builder: (context, constraints) {
            double buttonWidth =
                constraints.maxWidth * 0.8; // 80% širine dostupnog prostora

            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //login button
                SizedBox(
                  width: buttonWidth,
                  child: ElevatedButton(
                    onPressed: () => Navigator.of(context).push(
                        MaterialPageRoute(
                            builder: (context) => const LoginScreen())),
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(15), // Manje zaobljeni rubovi
                      ),
                      padding: const EdgeInsets.symmetric(
                          vertical: 20), //Visina gumba
                    ),
                    child: const Text(
                      "PRIJAVA",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                    ),
                  ),
                ),
                const SizedBox(height: 40),

                //registration button
                SizedBox(
                  width: buttonWidth,
                  child: ElevatedButton(
                    onPressed: () => Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const RegistrationScreen(),
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(15), // Manje zaobljeni rubovi
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 20),
                    ),
                    child: const Text(
                      "REGISTRACIJA",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                    ),
                  ),
                ),

                const SizedBox(height: 40),

                //additional button
                SizedBox(
                  width: buttonWidth,
                  child: ElevatedButton(
                    onPressed: () => Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (context) => const TabScreen(),
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(15), // Manje zaobljeni rubovi
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 20),
                    ),
                    child: const Text(
                      "Go to Home screen",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
