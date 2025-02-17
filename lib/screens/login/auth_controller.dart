import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:povedi_me_app/services/auth_service.dart';

class AuthController {
  final AuthService _authService;

  AuthController(this._authService);

  Future<String?> signIn(
    String email,
    String password, {
    required VoidCallback onSuccess,
    required ValueChanged<String> onError,
  }) async {
    try {
      await _authService.signInUser(email, password);
      onSuccess();
      return null;
    } catch (e) {
      if (e is FirebaseAuthException) {
        final errorMessage = e.message;
        onError(errorMessage!);
        return errorMessage;
      } else {
        const unknownErrorMessage = 'Dogodila se pogreška. Pokušajte ponovo.';
        onError(unknownErrorMessage);
        return unknownErrorMessage;
      }
    }
  }
}
