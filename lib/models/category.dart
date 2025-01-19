class Category {
  const Category({
    required this.id,
    required this.title,
    required this.icon,
  });

  final String id;
  final String title;
  final String icon;
}

class Subcategory {
  const Subcategory({
    required this.id,
    required this.categoryId, // Veza s kategorijom
    required this.title,
  });

  final String id;
  final String categoryId; // Referenca na glavnu kategoriju
  final String title;
}
