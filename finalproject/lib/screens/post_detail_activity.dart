import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../models/post.dart';
import '../services/firestore_service.dart';
import '../services/storage_service.dart';
import '../widgets/full_image_view.dart';

class PostDetailActivity extends StatelessWidget {
  final Post post;
  const PostDetailActivity({super.key, required this.post});

  Future<void> _delete(BuildContext ctx) async {
    if (post.userId != FirebaseAuth.instance.currentUser?.uid) {
      ScaffoldMessenger.of(ctx)
          .showSnackBar(const SnackBar(content: Text('Not your post')));
      return;
    }
    final fs = FirestoreService();
    final st = StorageService();
    final imgs = await fs.deletePost(post.id);
    await st.deleteImages(imgs);
    Navigator.pop(ctx);
    ScaffoldMessenger.of(ctx)
        .showSnackBar(const SnackBar(content: Text('Post deleted')));
  }

  @override
  Widget build(BuildContext context) {
    final isOwner = post.userId == FirebaseAuth.instance.currentUser?.uid;
    return Scaffold(
      appBar: AppBar(
        title: Text(post.title),
        actions: isOwner
            ? [
                IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () => _delete(context))
              ]
            : null,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text('\$${post.price}', style: const TextStyle(fontSize: 24)),
          const SizedBox(height: 10),
          Text(post.description),
          const SizedBox(height: 20),
          Wrap(
            spacing: 8,
            children: post.images
                .map((u) => GestureDetector(
                      child: Image.network(u,
                          width: 80, height: 80, fit: BoxFit.cover),
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => FullImageView(imageUrl: u)),
                      ),
                    ))
                .toList(),
          )
        ]),
      ),
    );
  }
}
