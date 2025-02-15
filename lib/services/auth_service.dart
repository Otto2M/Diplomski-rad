import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:povedi_me_app/constants/errors.dart';
import 'package:povedi_me_app/constants/firestore_collections.dart';
import 'package:povedi_me_app/models/user.dart' as user;

class AuthService {
  final _firebaseAuth = FirebaseAuth.instance;
  final _firebaseFirestore = FirebaseFirestore
      .instance; //for "talking" to remote database (upload/fetch data)

  //Log in user
  Future<void> signInUser(String email, String password) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (error) {
      if (error.code == Errors.emailAlreadyInUse) {
        //TODO error message print
      }
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
      final userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);

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
      if (error.code == Errors.emailAlreadyInUse) {
        throw Exception('Email već postoji!');
      } else {
        throw Exception(
            'Došlo je do greške pri registraciji: ${error.message}');
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
    try {
      await _firebaseAuth.signOut();
      print('---- KORISNIK ODJAVLJEN! -----');
    } catch (e) {
      print('Odjava nije uspjela: $e');
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
      print('Error fetching user profile data: $e');
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
      print('Error updating user profile data: $e');
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
