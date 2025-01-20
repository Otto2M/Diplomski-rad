import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:povedi_me_app/models/category.dart';
import 'package:povedi_me_app/services/auth_service.dart';
import 'package:povedi_me_app/services/cloud_firestore_service.dart';

final firestoreDatabaseService = Provider<AuthService>((ref) => AuthService());

// Categories Provider
final categoriesProvider = FutureProvider<List<Category>>((ref) async {
  final authService = ref.watch(firestoreDatabaseService);
  return await authService.getCategories();
});

// Subcategories Provider
final subcategoriesProvider = FutureProvider<List<Subcategory>>((ref) async {
  final authService = ref.watch(firestoreDatabaseService);
  return await authService.getSubcategories();
});

// // Places Provider
// final placesProvider = FutureProvider<List<Place>>((ref) async {
//   final authService = ref.watch(categoriesProvider);
//   return await authService.fetchPlaces();
// });
