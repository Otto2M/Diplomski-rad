class Category {
  const Category({
    required this.id,
    required this.title,
    required this.icon,
  });

  final String id;
  final String title;
  final String icon;

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'icon': icon,
    };
  }

  factory Category.fromMap(Map<String, dynamic> map) {
    return Category(
      id: map['id'],
      title: map['title'],
      icon: map['icon'],
    );
  }
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
