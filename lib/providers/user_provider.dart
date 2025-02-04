import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:povedi_me_app/models/user.dart' as user;
import 'package:povedi_me_app/services/auth_service.dart';

final authServiceProvider = Provider<AuthService>((ref) {
  return AuthService();
});

final userProvider = FutureProvider<user.User?>((ref) async {
  final authService = ref.read(authServiceProvider);

  // Dohvaćanje trenutno prijavljenog korisnika iz FirebaseAuth
  final firebaseUser = await authService.getCurrentUser();
  if (firebaseUser == null) {
    return null;
  }

  // Dohvaćanje dodatnih podataka iz Firestore-a
  return authService.getUserProfile(firebaseUser.uid);
});
