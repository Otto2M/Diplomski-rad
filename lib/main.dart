import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';

import 'package:povedi_me_app/providers/theme_mode_option_provider.dart';
import 'package:povedi_me_app/screens/splash/auth_gate.dart';
import 'package:povedi_me_app/theme.dart';

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

class App extends ConsumerWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeProvider);

    return MaterialApp(
      theme: lightAppTheme,
      darkTheme: darkAppTheme,
      themeMode: themeMode,
      //home: const TabScreen(),
      // home: const SplashScreen(),
      home: const AuthGate(),
      debugShowCheckedModeBanner: false,
    );
  }
}
