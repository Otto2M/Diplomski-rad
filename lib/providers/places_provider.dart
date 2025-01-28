import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:povedi_me_app/constants/firestore_collections.dart';
import 'package:povedi_me_app/models/place.dart';

final placesProvider = StreamProvider<List<dynamic>>((ref) async* {
  final snapshot = FirebaseFirestore.instance
      .collection(FirestoreCollections.placesCollection)
      .snapshots();

  // Slijed podataka iz Firestore
  await for (var querySnapshot in snapshot) {
    yield querySnapshot.docs.map((doc) {
      final data = doc.data();

      switch (data['type']) {
        case 'details':
          return PlaceWithDetails(
            id: data['id'],
            categoryId: data['categoryId'],
            subcategoryId: data['subcategoryId'],
            title: data['title'],
            description: data['description'],
            imageUrl: data['imageUrl'] is String
                ? [
                    data['imageUrl']
                  ] // Ako je imageUrl String, stvori listu s jednim elementom
                : List<String>.from(
                    data['imageUrl'] ?? []), // Inače pretvori u List<String>

            address: data['address'],
            coordinates: Map<String, double>.from(data['coordinates']),
            workingHours: data['workingHours'] != null
                ? Map<String, String>.from(data['workingHours'])
                : null,
            reviews: List<String>.from(data['reviews'] ?? []),
            contactNumber: data['contactNumber'],
            email: data['email'],
            type: data['type'],
          );

        case 'shop':
          return ShoppingPlace(
            id: data['id'],
            categoryId: data['categoryId'],
            subcategoryId: data['subcategoryId'],
            title: data['title'],
            description: data['description'],
            imageUrl: data['imageUrl'] is String
                ? [data['imageUrl']]
                : List<String>.from(data['imageUrl'] ?? []),
            address: data['address'],
            coordinates: Map<String, double>.from(data['coordinates']),
            workingHours: data['workingHours'] != null
                ? Map<String, String>.from(data['workingHours'])
                : null,
            type: data['type'],
          );

        default:
          return Place(
            id: data['id'],
            categoryId: data['categoryId'],
            subcategoryId: data['subcategoryId'],
            title: data['title'],
            description: data['description'],
            imageUrl: data['imageUrl'] is String
                ? [
                    data['imageUrl']
                  ] // Ako je imageUrl String, stvori listu s jednim elementom
                : List<String>.from(data['imageUrl'] ?? []),
            address: data['address'],
            coordinates: data['coordinates'] != null
                ? (data['coordinates'] as Map<String, dynamic>).map(
                    (key, value) =>
                        MapEntry(key, double.tryParse(value.toString()) ?? 0.0),
                  )
                : {},
            type: data['type'],
            date: data['date'] != null
                ? (data['date'] as Timestamp).toDate()
                : null,
          );
      }
    }).toList();
  }
});
