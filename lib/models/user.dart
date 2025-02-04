import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  User({
    required this.id,
    required this.name,
    required this.username,
    required this.email,
    required this.phoneNumber,
    required this.createdAt,
    this.imageUrl,
  });

  final String id;
  final String name;
  final String username;
  final String email;
  final String phoneNumber;
  final DateTime createdAt;
  final String? imageUrl;

  factory User.fromFirestore(Map<String, dynamic> data) {
    return User(
      id: data['id'],
      name: data['name'] as String,
      username: data['username'] as String,
      email: data['email'] as String,
      phoneNumber: data['phoneNumber'] as String? ?? '',
      createdAt: (data['createdAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
      imageUrl: data['image_url'] as String? ?? '',
    );
  }

  // Pretvaranje User objekta u mapu za Firestore
  Map<String, dynamic> toFirestore() {
    return {
      'id': id,
      'name': name,
      'username': username,
      'email': email,
      'phoneNumber': phoneNumber,
      'createdAt': createdAt,
      'image_url': imageUrl,
    };
  }
}
