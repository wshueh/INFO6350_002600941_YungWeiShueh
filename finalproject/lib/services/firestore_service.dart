import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/post.dart';

class FirestoreService {
  final _posts = FirebaseFirestore.instance.collection('posts');

  Future<String> createPost(Post post) async {
    final doc = await _posts.add(post.toMap());
    return doc.id;
  }

  Future<void> updatePostImages(String id, List<String> urls) async {
    await _posts.doc(id).update({
      'images': urls,
      'updatedAt': FieldValue.serverTimestamp(),
    });
  }

  Future<List<String>> deletePost(String id) async {
    final snap = await _posts.doc(id).get();
    final imgs = List<String>.from(snap['images'] ?? []);
    await _posts.doc(id).delete();
    return imgs;
  }

  Stream<List<Post>> getPosts() => _posts
      .orderBy('timestamp', descending: true)
      .snapshots()
      .map((s) => s.docs
          .map((d) => Post.fromMap(d.id, d.data() as Map<String, dynamic>))
          .toList());
}
