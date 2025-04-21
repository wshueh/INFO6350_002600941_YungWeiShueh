import 'package:cloud_firestore/cloud_firestore.dart';

class Post {
  final String id;
  final String userId;
  final String title;
  final double price;
  final String description;
  final List<String> images;
  final DateTime timestamp;

  Post({
    required this.id,
    required this.userId,
    required this.title,
    required this.price,
    required this.description,
    required this.images,
    required this.timestamp,
  });

  factory Post.fromMap(String id, Map<String, dynamic> data) => Post(
        id: id,
        userId: data['userId'] ?? '',
        title: data['title'],
        price: (data['price'] as num).toDouble(),
        description: data['description'],
        images: List<String>.from(data['images'] ?? []),
        timestamp: (data['timestamp'] as Timestamp).toDate(),
      );

  Map<String, dynamic> toMap() => {
        'userId': userId,
        'title': title,
        'price': price,
        'description': description,
        'images': images,
        'timestamp': timestamp,
      };
}
