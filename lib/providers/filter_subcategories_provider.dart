import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:povedi_me_app/models/category.dart';
import 'package:povedi_me_app/models/place.dart';
import 'package:povedi_me_app/providers/categories_provider.dart';

final filteredSubcategoriesProvider =
    Provider.family<List<Subcategory>, String>((ref, categoryId) {
  final subcategoriesAsyncValue = ref.watch(subcategoriesProvider);

  return subcategoriesAsyncValue.when(
    data: (subcategories) {
      return subcategories
          .where((subcategory) => subcategory.categoryId == categoryId)
          .toList();
    },
    loading: () => [],
    error: (error, stackTrace) => [],
  );
});

final subcategoryForPlaceProvider =
    Provider.family<Subcategory?, Place>((ref, place) {
  final subcategoriesAsyncValue = ref.watch(subcategoriesProvider);

  return subcategoriesAsyncValue.when(
    data: (subcategories) {
      if (place.subcategoryId == null) return null;

      return subcategories
          .firstWhere((subcategory) => subcategory.id == place.subcategoryId);
    },
    loading: () => null,
    error: (error, stackTrace) => null,
  );
});
