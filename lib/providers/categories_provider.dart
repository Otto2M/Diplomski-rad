import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:povedi_me_app/models/category.dart';
import 'package:povedi_me_app/services/cloud_firestore_service.dart';

final firestoreDatabaseService =
    Provider<FirestoreDatabaseService>((ref) => FirestoreDatabaseService());

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
