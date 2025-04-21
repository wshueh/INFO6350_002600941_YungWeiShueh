import 'package:flutter/material.dart';
import '../models/post.dart';
import '../services/firestore_service.dart';
import '../services/auth_service.dart';
import '../widgets/post_card.dart';
import 'new_post_activity.dart';
import 'post_detail_activity.dart';

class BrowsePostsActivity extends StatefulWidget {
  @override
  State<BrowsePostsActivity> createState() => _BrowsePostsActivityState();
}

class _BrowsePostsActivityState extends State<BrowsePostsActivity> {
  final _fs = FirestoreService();
  final _auth = AuthService();

  Future<void> _goNewPost() async {
    final success = await Navigator.push<bool>(
      context,
      MaterialPageRoute(builder: (_) => NewPostActivity()),
    );
    if (success == true && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Post added')),
      );
    }
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('HyperGarageSale'),
          actions: [
            IconButton(
                icon: const Icon(Icons.logout), onPressed: _auth.signOut),
            IconButton(icon: const Icon(Icons.add), onPressed: _goNewPost),
          ],
        ),
        body: StreamBuilder<List<Post>>(
          stream: _fs.getPosts(),
          builder: (_, snap) {
            if (!snap.hasData) {
              return const Center(child: CircularProgressIndicator());
            }
            final posts = snap.data!;
            if (posts.isEmpty) return const Center(child: Text('No posts yet'));

            return ListView.builder(
              itemCount: posts.length,
              itemBuilder: (_, i) => GestureDetector(
                child: PostCard(post: posts[i]),
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) => PostDetailActivity(post: posts[i])),
                ),
              ),
            );
          },
        ),
        floatingActionButton: FloatingActionButton(
            child: const Icon(Icons.add), onPressed: _goNewPost),
      );
}
