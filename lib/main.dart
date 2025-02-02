import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:povedi_me_app/screens/home/demo/demo_home_screen.dart';
import 'package:povedi_me_app/screens/home/home_screen.dart';
import 'package:povedi_me_app/screens/splash/initial_screen.dart';
import 'package:povedi_me_app/screens/splash/loading_screen.dart';
import 'package:povedi_me_app/screens/splash/splash_screen.dart';
import 'package:povedi_me_app/screens/splash/welcome_screen.dart';
import 'package:povedi_me_app/theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:povedi_me_app/widgets/tab_screen.dart';
import 'firebase_options.dart';
import 'package:povedi_me_app/constants/instances.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/services.dart';

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
  SystemChrome.setEnabledSystemUIMode(
    SystemUiMode.manual,
    overlays: [SystemUiOverlay.top],
  ); //ili SystemUiMode.edgeToEdge ili SystemUiMode.immersiveSticky
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: lightAppTheme,
      darkTheme: darkAppTheme,
      //themeMode: ,
      home: const TabScreen(),
      //home: const SplashScreen(),
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
      //initialRoute: ,
      debugShowCheckedModeBanner: false,
    );
  }
}
