import 'package:flutter/material.dart';
import 'package:povedi_me_app/constants/instances.dart';

class HelpScreen extends StatelessWidget {
  const HelpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Help/Settings screen"),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            firebaseAuth.signOut();
          },
          child: const Text("Log out"),
        ),
      ),
    );
  }
}
