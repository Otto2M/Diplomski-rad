import 'package:flutter/material.dart';
import 'package:povedi_me_app/constants/instances.dart';
import 'package:povedi_me_app/screens/help_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

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
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Logged in!"),
            // ElevatedButton(
            //   onPressed: () => Navigator.of(context).push(
            //     MaterialPageRoute(
            //       builder: (context) => HelpScreen(),
            //     ),
            //   ),
            //   child: Text("Go to - logout"),
            // ),
          ],
        ),
      ),
    );
  }
}
