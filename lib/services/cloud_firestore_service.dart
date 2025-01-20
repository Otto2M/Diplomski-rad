import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:povedi_me_app/constants/firestore_collections.dart';
import 'package:povedi_me_app/models/category.dart';

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

//
// --- AKO DOHVACANJE MJESTA I OBRADA U places_provider.dart NECE ISPROBATI OVO ISPOD
// --- POTREBNO JE KOD PRILAGODITI

  // Fetch places
  // Future<List<Place>> fetchPlaces() async {
  //   try {
  //     final snapshot = await _firebaseFirestore
  //         .collection(FirestoreCollections.placesCollection)
  //         .get();
  //     return snapshot.docs
  //         .map((doc) => Place(
  //               id: doc['id'],
  //               categoryId: doc['categoryId'],
  //               subcategoryId: doc['subcategoryId'],
  //               title: doc['title'],
  //               description: doc['description'],
  //               imageUrl: doc['imageUrl'],
  //               adress: doc['adress'],
  //               coordinates: Map<String, double>.from(doc['coordinates']),
  //             ))
  //         .toList();
  //   } catch (e) {
  //     print('Error fetching places: $e');
  //     rethrow;
  //   }
  // }
}
