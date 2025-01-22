import 'package:flutter/material.dart';
import 'package:povedi_me_app/constants/instances.dart';
import 'package:povedi_me_app/screens/help_screen.dart';
import 'package:povedi_me_app/screens/home/about_city_screen.dart';

class HomeScreen2 extends StatelessWidget {
  const HomeScreen2({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home screen"),
        actions: [
          IconButton(
            onPressed: () {
              firebaseAuth.signOut();
            },
            icon: Icon(Icons.exit_to_app),
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Logged in!"),
            ElevatedButton(
              onPressed: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => HelpScreen(),
                ),
              ),
              child: const Text("Go to - logout"),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const AboutCityScreen(),
                ),
              ),
              child: const Text("O KOPRIVNICI"),
            ),
          ],
        ),
      ),
    );
  }
}
