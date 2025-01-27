import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:povedi_me_app/screens/home/home_screen.dart';
import 'package:povedi_me_app/screens/home/home_screen_2.dart';
import 'package:povedi_me_app/screens/splash/loading_screen.dart';
import 'package:povedi_me_app/screens/splash/splash_screen.dart';
import 'package:povedi_me_app/screens/splash/welcome_screen.dart';
import 'package:povedi_me_app/theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:povedi_me_app/widgets/drawer_menu.dart';
import 'firebase_options.dart';
import 'package:povedi_me_app/constants/instances.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    const ProviderScope(
      child: App(),
    ),
  );
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: appTheme,
      //home: SplashScreen(), //fix this at open app
      //home: const DrawerMenu(),
      home: const HomeScreen2(),
      // home: StreamBuilder(
      //     stream: FirebaseAuth.instance.authStateChanges(),
      //     builder: (ctx, snapshot) {
      //       print(
      //           'Auth state changed: ${snapshot.connectionState}, User: ${snapshot.data}');
      //       //like splash screen
      //       if (snapshot.connectionState == ConnectionState.waiting) {
      //         return const LoadingScreen();
      //       }
      //       print("-------------- ULAZIM U METODU: --------------------");

      //       if (snapshot.hasData) {
      //         print("-------------- IMA PODATAKA --------------------");
      //         return const HomeScreen();
      //       }

      //       print("-------------- NEMA PODATAKA --------------------");
      //       return const WelcomeScreen();
      //     }),
    );
  }
}
