import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:povedi_me_app/models/category.dart';

class SharedPreferencesService {
  Future<void> saveCategoriesToCache(List<Category> categories) async {
    final prefs = await SharedPreferences.getInstance();
    final categoriesJson =
        categories.map((category) => category.toMap()).toList();
    final categoriesString = json.encode(categoriesJson);

    await prefs.setString('categories', categoriesString);
  }

  Future<List<Category>> loadCategoriesFromCache() async {
    final prefs = await SharedPreferences.getInstance();
    final categoriesString = prefs.getString('categories');

    if (categoriesString != null) {
      final List<dynamic> categoriesList = json.decode(categoriesString);
      return categoriesList.map((e) => Category.fromMap(e)).toList();
    }
    return [];
  }
}
