import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:povedi_me_app/models/category.dart';
import 'package:povedi_me_app/models/city.dart';
import 'package:povedi_me_app/services/cloud_firestore_service.dart';

final firestoreDatabaseService =
    Provider<FirestoreDatabaseService>((ref) => FirestoreDatabaseService());

// Categories Provider
final categoriesProvider = FutureProvider<List<Category>>((ref) async {
  final firebaseFirestoreService = ref.watch(firestoreDatabaseService);
  return await firebaseFirestoreService.getCategories();
});

// Subcategories Provider
final subcategoriesProvider = FutureProvider<List<Subcategory>>((ref) async {
  final firebaseFirestoreService = ref.watch(firestoreDatabaseService);
  return await firebaseFirestoreService.getSubcategories();
});

final combinedCategoriesAndSubcategroiesProvider = FutureProvider((ref) async {
  final categories = await ref.watch(categoriesProvider.future);
  final subcategories = await ref.watch(subcategoriesProvider.future);
  return {
    'categories': categories,
    'subcategories': subcategories,
  };
});

// AboutCity Provider
final aboutCityDataProvider = FutureProvider<List<AboutCity>>((ref) async {
  final firebaseFirestoreService = ref.watch(firestoreDatabaseService);
  return await firebaseFirestoreService.getDataAboutCity();
});
