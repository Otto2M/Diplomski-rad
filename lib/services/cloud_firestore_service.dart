import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:povedi_me_app/constants/firestore_collections.dart';
import 'package:povedi_me_app/models/category.dart';
import 'package:povedi_me_app/models/city.dart';
import 'package:povedi_me_app/services/shared_preferences_service.dart';

class FirestoreDatabaseService {
  final _firebaseFirestore = FirebaseFirestore
      .instance; //for "talking" to remote database (upload/fetch data)
  final sharedPreferencesService = SharedPreferencesService();

  // Get all categories
  Future<List<Category>> getCategories() async {
    try {
      final categoriesSnapshot = await _firebaseFirestore
          .collection(FirestoreCollections.categoriesCollection)
          .get();

      final categories = categoriesSnapshot.docs
          .map((doc) => Category(
                id: doc['id'],
                title: doc['title'],
                icon: doc['icon'],
              ))
          .toList();

      await sharedPreferencesService.saveCategoriesToCache(categories);
      return categories;
    } catch (e) {
      debugPrint('Error fetching categories: $e');
      rethrow;
    }
  }

  Future<List<Category>> loadCategoriesFromCache() async {
    return await sharedPreferencesService.loadCategoriesFromCache();
  }

  // Get all subcategories
  Future<List<Subcategory>> getSubcategories() async {
    try {
      final subcategoriesSnapshot = await _firebaseFirestore
          .collection(FirestoreCollections.subcategoriesCollection)
          .get();

      return subcategoriesSnapshot.docs
          .map((doc) => Subcategory(
                id: doc['id'],
                categoryId: doc['categoryId'],
                title: doc['title'],
              ))
          .toList();
    } catch (e) {
      debugPrint('Error fetching subcategories: $e');
      rethrow;
    }
  }

  // Get data about city
  Future<List<AboutCity>> getDataAboutCity() async {
    try {
      final aboutCitySnapshot = await _firebaseFirestore
          .collection(FirestoreCollections.aboutCityCollection)
          .get();

      return aboutCitySnapshot.docs
          .map((doc) => AboutCity(
                id: doc['id'],
                title: doc['title'],
                subtitle: doc['subtitle'],
                description: doc['description'],
                imageUrl: doc['imageUrl'] is String
                    ? [doc['imageUrl']]
                    : List<String>.from(doc['imageUrl'] ?? []),
              ))
          .toList();
    } catch (e) {
      debugPrint('Error fetching data about city: $e');
      rethrow;
    }
  }

  // Get data about perfect day in city
  Future<List<PerfectDay>> getAllPerfectDaysData() async {
    try {
      final perfectDaySnapshot = await _firebaseFirestore
          .collection(FirestoreCollections.perfectDaysCollection)
          .get();

      return perfectDaySnapshot.docs
          .map(
            (doc) => PerfectDay(
              title: doc['title'],
              description: doc['description'],
              imageUrl: doc['imageUrl'],
              sections: (doc['sections'] as List).map((section) {
                return Section(
                  timeOfDay: section['timeOfDay'],
                  content: section['content'],
                );
              }).toList(),
              additionalTips: doc['additionalTips'] ?? '',
              conclusion: doc['conclusion'],
            ),
          )
          .toList();
    } catch (e) {
      debugPrint('Error fetching data about perfect day in city: $e');
      rethrow;
    }
  }

  Future<void> saveReview({
    required String userId,
    required String placeId,
    required double rating,
  }) async {
    try {
      final userRef = _firebaseFirestore
          .collection(FirestoreCollections.userCollection)
          .doc(userId);

      await userRef.set(
        {
          'reviews': {
            placeId: rating,
          }
        },
        SetOptions(merge: true),
      );
      debugPrint('Recenzija uspješno spremljena.');
    } catch (e) {
      debugPrint('Greška pri spremanju recenzije: $e');
    }
  }

  Future<void> updateAverageRating({
    required String placeId,
    required Map<String, double> userReviews,
  }) async {
    try {
      final totalReviews = userReviews.values.length;
      final averageRating = totalReviews > 0
          ? userReviews.values.reduce((a, b) => a + b) / totalReviews
          : 0.0;

      // Ažuriranje prosječne ocjene u Firestore-u
      final placeRef = _firebaseFirestore
          .collection(FirestoreCollections.placesCollection)
          .doc(placeId);
      await placeRef.update({'averageRating': averageRating});
    } catch (e) {
      debugPrint('Greška pri ažuriranju prosječne ocjene: $e');
    }
  }

  /// Dohvaća sve recenzije za određeno mjesto iz kolekcije korisnika
  Future<Map<String, double>> getAllReviewsForPlace(String placeId) async {
    try {
      final usersSnapshot = await _firebaseFirestore
          .collection(FirestoreCollections.userCollection)
          .get();

      final Map<String, double> reviewsMap = {};

      for (var userDoc in usersSnapshot.docs) {
        final userReviews = userDoc.data()['reviews'] as Map<String, dynamic>?;

        if (userReviews != null && userReviews.containsKey(placeId)) {
          reviewsMap[userDoc.id] = userReviews[placeId].toDouble();
        }
      }
      return reviewsMap;
    } catch (e) {
      debugPrint('Greška pri dohvaćanju recenzija: $e');
      return {};
    }
  }

  Future<void> saveImageUrlsToPlace(
      String placeId, List<String> imageUrls) async {
    try {
      final placeRef = _firebaseFirestore
          .collection(FirestoreCollections.placesCollection)
          .doc(placeId);

      await placeRef.update({
        'imageUrl': FieldValue.arrayUnion(imageUrls),
      });

      print(" ---- URL-ovi uspješno pohranjeni! ---- ");
    } catch (e) {
      print(" !!!! Greška pri spremanju URL-ova: $e !!!! ");
    }
  }
}
