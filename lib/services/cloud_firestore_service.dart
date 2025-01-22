import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:povedi_me_app/constants/firestore_collections.dart';
import 'package:povedi_me_app/models/category.dart';
import 'package:povedi_me_app/models/place.dart';

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
}
