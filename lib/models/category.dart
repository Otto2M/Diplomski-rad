class Category {
  const Category({
    required this.id,
    required this.title,
    required this.icon,
    required this.translated,
  });

  final String id;
  final String title;
  final String icon;
  final Map<String, dynamic> translated;

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'icon': icon,
      'translated': translated,
    };
  }

  factory Category.fromMap(Map<String, dynamic> map, String lang) {
    final Map<String, dynamic>? translations = map['translated'];

    final String translatedTitle =
        translations != null && translations.containsKey(lang)
            ? (translations[lang].toString())
            : map['title'].toString();

    return Category(
      id: map['id'].toString(),
      title: translatedTitle,
      icon: map['icon'].toString(),
      translated: translations ?? {},
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
