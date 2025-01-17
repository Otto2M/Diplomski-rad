import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:povedi_me_app/constants/errors.dart';

class AuthService {
  final _firebaseAuth = FirebaseAuth.instance;

  //Log in user
  Future<void> signInUser(String email, String password) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (error) {
      if (error.code == Errors.emailAlreadyInUse) {
        //TO DO error message print
      }
    }
  }

  //Register new user
  Future<void> signUp({required String email, required String password}) async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (error) {
      if (error.code == Errors.emailAlreadyInUse) {
        //TO DO error message print
      }
    }
  }

  //Sign in with Google Account
  Future<void> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      if (googleUser == null) {
        // Korisnik je odustao od prijave
        return;
      }

      // Dohvati autentifikacijski objekt
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      // Stvori Firebase autentifikacijske vjerodajnice
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Prijavi korisnika u Firebase pomoću Google vjerodajnica
      await _firebaseAuth.signInWithCredential(credential);

      print('Google sign-in successful!');
    } catch (e) {
      print(e.toString());
    }
  }

  //Sign out user
  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }
}
