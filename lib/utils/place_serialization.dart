import 'package:povedi_me_app/models/place.dart';

Map<String, dynamic> serializePlace(Place place) {
  final baseData = {
    'id': place.id,
    'categoryId': place.categoryId,
    'subcategoryId': place.subcategoryId,
    'title': place.title,
    'description': place.description,
    'imageUrl': place.imageUrl,
    'address': place.address,
    'coordinates': place.coordinates,
    'type': place.type,
    'date': place.date?.toIso8601String(),
  };

  if (place is PlaceWithDetails) {
    return {
      ...baseData,
      // Dodano za identifikaciju tipa
      'objectType': 'placeWithDetails',
      'workingHours': place.workingHours,
      'reviews': place.reviews,
      'contactNumber': place.contactNumber,
      'email': place.email,
      'averageRating': place.averageRating,
    };
  }

  return {
    ...baseData,
    'objectType': 'place',
  };
}

Place deserializePlace(Map<String, dynamic> json) {
  final objectType = json['objectType'];

  if (objectType == 'placeWithDetails') {
    return PlaceWithDetails(
      id: json['id'],
      categoryId: json['categoryId'],
      subcategoryId: json['subcategoryId'],
      title: json['title'],
      description: json['description'],
      imageUrl: List<String>.from(json['imageUrl']),
      address: json['address'],
      coordinates: Map<String, double>.from(json['coordinates']),
      type: json['type'],
      // date: json['date'] != null ? DateTime.parse(json['date']) : null,
      workingHours: json['workingHours'] != null
          ? Map<String, String>.from(json['workingHours'])
          : null,
      reviews:
          json['reviews'] != null ? List<String>.from(json['reviews']) : null,
      contactNumber: json['contactNumber'],
      email: json['email'],
      averageRating: json['averageRating'],
    );
  }

  return Place(
    id: json['id'],
    categoryId: json['categoryId'],
    subcategoryId: json['subcategoryId'],
    title: json['title'],
    description: json['description'],
    imageUrl: List<String>.from(json['imageUrl']),
    address: json['address'],
    coordinates: Map<String, double>.from(json['coordinates']),
    type: json['type'],
    date: json['date'] != null ? DateTime.parse(json['date']) : null,
  );
}
