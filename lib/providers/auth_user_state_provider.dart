import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Stream za praćenje promjena autentifikacijskog statusa
final authStateProvider = StreamProvider<User?>(
  (ref) {
    return FirebaseAuth.instance.authStateChanges();
  },
);
