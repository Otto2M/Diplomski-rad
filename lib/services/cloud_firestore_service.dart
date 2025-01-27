import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:povedi_me_app/constants/firestore_collections.dart';
import 'package:povedi_me_app/models/category.dart';
import 'package:povedi_me_app/models/city.dart';

class FirestoreDatabaseService {
  final _firebaseFirestore = FirebaseFirestore
      .instance; //for "talking" to remote database (upload/fetch data)

  // Get all categories
  Future<List<Category>> getCategories() async {
    try {
      final categoriesSnapshot = await _firebaseFirestore
          .collection(FirestoreCollections.categoriesCollection)
          .get();

      return categoriesSnapshot.docs
          .map((doc) => Category(
                id: doc['id'],
                title: doc['title'],
                icon: doc['icon'],
              ))
          .toList();
    } catch (e) {
      print('Error fetching categories: $e');
      rethrow;
    }
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
      print('Error fetching subcategories: $e');
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
                imageUrl: doc['imageUrl'],
              ))
          .toList();
    } catch (e) {
      print('Error fetching data about city: $e');
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
      print('Error fetching data about perfect day in city: $e');
      rethrow;
    }
  }

  // Future<void> saveImageUrlsToPlace(
  //     String placeId, List<String> imageUrls) async {
  //   try {
  //     final placeRef = _firebaseFirestore
  //         .collection(FirestoreCollections.placesCollection)
  //         .doc(placeId);

  //     await placeRef.update({
  //       'imageUrl': FieldValue.arrayUnion(imageUrls),
  //     });

  //     print("URL-ovi uspješno pohranjeni!");
  //   } catch (e) {
  //     print("Greška pri spremanju URL-ova: $e");
  //   }
  // }
}
