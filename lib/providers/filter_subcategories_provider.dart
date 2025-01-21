import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:povedi_me_app/models/category.dart';
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
