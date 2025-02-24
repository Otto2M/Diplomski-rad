import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:povedi_me_app/constants/firestore_collections.dart';
import 'package:povedi_me_app/models/user.dart' as user;

class AuthService {
  final _firebaseAuth = FirebaseAuth.instance;
  final _firebaseFirestore = FirebaseFirestore
      .instance; //for "talking" to remote database (upload/fetch data)

  Future<void> signInUser(String email, String password) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (error) {
      throw FirebaseAuthException(
        code: error.code,
        message: getErrorMessage(error),
      );
    }
  }

  String getErrorMessage(FirebaseAuthException error) {
    switch (error.code) {
      case 'user-not-found':
        return 'Korisnik s tim emailom nije pronađen.';
      case 'wrong-password':
        return 'Pogrešna lozinka.';
      case 'too-many-requests':
        return 'Previše pokušaja. Pokušajte ponovno kasnije.';
      case 'invalid-email':
        return 'Neispravan format email adrese.';
      case 'invalid-credential':
        return 'Pogrešna lozinka ili neispravan korisnički račun.';
      default:
        return 'Dogodila se pogreška. Pokušajte ponovo.';
    }
  }

  //Register new user
  Future<void> signUp({
    required String email,
    required String password,
    required String username,
    required String name,
    required String phoneNumber,
  }) async {
    try {
      if (await _isUsernameTaken(username)) {
        throw 'Korisničko ime je već zauzeto.';
      }

      final userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      _firebaseFirestore
          .collection(FirestoreCollections.userCollection)
          .doc(userCredential.user!.uid)
          .set({
        'id': userCredential.user!.uid,
        'name': name,
        'username': username,
        'phoneNumber': phoneNumber,
        'email': email,
        'image_url':
            "https://w7.pngwing.com/pngs/177/551/png-transparent-user-interface-design-computer-icons-default-stephen-salazar-graphy-user-interface-design-computer-wallpaper-sphere-thumbnail.png",
        'createdAt': Timestamp.now(),
        'reviews': null
      });
    } on FirebaseAuthException catch (error) {
      throw FirebaseAuthException(
        code: error.code,
        message: _handleFirebaseAuthError(error),
      );
    }
  }

  // Provjera korisničkog imena u bazi
  Future<bool> _isUsernameTaken(String username) async {
    final snapshot = await _firebaseFirestore
        .collection(FirestoreCollections.userCollection)
        .where('username', isEqualTo: username)
        .get();
    return snapshot.docs.isNotEmpty;
  }

  String _handleFirebaseAuthError(FirebaseAuthException error) {
    switch (error.code) {
      case 'email-already-in-use':
        return 'Email već postoji!';
      case 'weak-password':
        return 'Lozinka je previše slaba. Koristite barem 6 znakova.';
      case 'too-many-requests':
        return 'Previše pokušaja. Pokušajte ponovno kasnije.';
      case 'invalid-email':
        return 'Email adresa nije ispravna.';
      case 'network-request-failed':
        return 'Problem sa internet vezom.';
      default:
        return 'Došlo je do greške prilikom registracije. Pokušajte ponovo.';
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

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final userCredential =
          await _firebaseAuth.signInWithCredential(credential);

      debugPrint('Google sign-in successful!');

      final userDoc = await _firebaseFirestore
          .collection(FirestoreCollections.userCollection)
          .doc(userCredential.user!.uid)
          .get();

      if (!userDoc.exists) {
        // Ako korisnik ne postoji, dodaj ga u bazu
        await _firebaseFirestore
            .collection(FirestoreCollections.userCollection)
            .doc(userCredential.user!.uid)
            .set({
          'id': userCredential.user!.uid,
          'name': googleUser.displayName ?? 'Nepoznato ime',
          'username': userCredential.user!.email,
          'phoneNumber': 'Nepoznati broj',
          'email': googleUser.email,
          'image_url': userCredential.user!.photoURL ??
              "https://w7.pngwing.com/pngs/177/551/png-transparent-user-interface-design-computer-icons-default-stephen-salazar-graphy-user-interface-design-computer-wallpaper-sphere-thumbnail.png", // Slika profila
          'createdAt': Timestamp.now(),
          'reviews': null
        });
        debugPrint('Korisnik je dodan u bazu!');
      } else {
        debugPrint('Korisnik već postoji u bazi.');
      }
    } catch (e) {
      debugPrint("Greška prilikom prijave: ${e.toString()}");
    }
  }

  //Sign out user
  Future<void> signOut() async {
    try {
      await _firebaseAuth.signOut();
    } catch (e) {
      debugPrint('Odjava nije uspjela: $e');
    }
  }

  Future<user.User?> getUserProfile(String userId) async {
    try {
      final doc = await _firebaseFirestore
          .collection(FirestoreCollections.userCollection)
          .doc(userId)
          .get();
      if (doc.exists) {
        return user.User.fromFirestore(doc.data()!);
      } else {
        //print("Dokument za korisnika ne postoji.");
      }
    } catch (e) {
      debugPrint('Error fetching user profile data: $e');
    }
    return null;
  }

  Future<void> updateUserProfile(String userId, user.User updatedUser) async {
    try {
      await _firebaseFirestore
          .collection(FirestoreCollections.userCollection)
          .doc(userId)
          .update(updatedUser.toFirestore());
    } catch (e) {
      debugPrint('Error updating user profile data: $e');
    }
  }

  Future<User?> getCurrentUser() async {
    try {
      final user = _firebaseAuth.currentUser;
      //print("Prijavljeni korisnik: $user");
      return user;
    } catch (e) {
      //print("Greška pri dohvaćanju prijavljenog korisnika: $e");
      return null;
    }
  }
}

  // // Get all categories
  // Future<List<Category>> getCategories() async {
  //   try {
  //     final categoriesSnapshot = await _firebaseFirestore
  //         .collection(FirestoreCollections.categoriesCollection)
  //         .get();

  //     return categoriesSnapshot.docs
  //         .map((doc) => Category(
  //               id: doc['id'],
  //               title: doc['title'],
  //               icon: doc['icon'],
  //             ))
  //         .toList();
  //   } catch (e) {
  //     print('Error fetching categories: $e');
  //     rethrow;
  //   }
  // }

  // // Get all subcategories
  // Future<List<Subcategory>> getSubcategories() async {
  //   try {
  //     final subcategoriesSnapshot = await _firebaseFirestore
  //         .collection(FirestoreCollections.subcategoriesCollection)
  //         .get();

  //     return subcategoriesSnapshot.docs
  //         .map((doc) => Subcategory(
  //               id: doc['id'],
  //               categoryId: doc['categoryId'],
  //               title: doc['title'],
  //             ))
  //         .toList();
  //   } catch (e) {
  //     print('Error fetching subcategories: $e');
  //     rethrow;
  //   }
  // }
