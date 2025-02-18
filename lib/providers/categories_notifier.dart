// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:povedi_me_app/models/category.dart';
// import 'package:povedi_me_app/services/cloud_firestore_service.dart';

// // Provider za kategorije i podkategorije
// final categoriesNotifierProvider =
//     StateNotifierProvider<CategoriesNotifier, Map<String, dynamic>>(
//         (ref) => CategoriesNotifier());

// class CategoriesNotifier extends StateNotifier<Map<String, dynamic>> {
//   CategoriesNotifier()
//       : super({
//           'categories': <Category>[],
//           'subcategories': <Subcategory>[],
//         }) {
//     _fetchData();
//   }

//   final FirestoreDatabaseService _firestoreDatabaseService =
//       FirestoreDatabaseService();

//   Future<void> _fetchData() async {
//     try {
//       final categories = await _firestoreDatabaseService.getCategories();
//       final subcategories = await _firestoreDatabaseService.getSubcategories();

//       state = {
//         'categories': categories,
//         'subcategories': subcategories,
//       };
//     } catch (e) {
//       // Ako se dogodi greška, stanje će biti prazno
//       state = {'categories': [], 'subcategories': []};
//     }
//   }
// }
