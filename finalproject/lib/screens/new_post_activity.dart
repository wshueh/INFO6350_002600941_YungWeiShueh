import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../models/post.dart';
import '../services/firestore_service.dart';
import '../services/storage_service.dart';

class NewPostActivity extends StatefulWidget {
  @override
  State<NewPostActivity> createState() => _NewPostActivityState();
}

class _NewPostActivityState extends State<NewPostActivity> {
  final _form = GlobalKey<FormState>();
  final _title = TextEditingController();
  final _price = TextEditingController();
  final _desc = TextEditingController();

  final _picker = ImagePicker();
  final _fs = FirestoreService();
  final _st = StorageService();
  final _imgs = <XFile>[];

  Future<void> _pick() async {
    if (_imgs.length >= 4) return;
    final src = await showModalBottomSheet<ImageSource>(
      context: context,
      builder: (_) => SafeArea(
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          ListTile(
              leading: const Icon(Icons.camera_alt),
              title: const Text('Take Photo'),
              onTap: () => Navigator.pop(context, ImageSource.camera)),
          ListTile(
              leading: const Icon(Icons.photo),
              title: const Text('Gallery'),
              onTap: () => Navigator.pop(context, ImageSource.gallery)),
        ]),
      ),
    );
    if (src == null) return;
    final pic = await _picker.pickImage(source: src);
    if (pic != null) setState(() => _imgs.add(pic));
  }

  Future<void> _submit() async {
    if (_form.currentState?.validate() != true) return;
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      _snack('Please login first');
      return;
    }

    final draft = Post(
      id: '',
      userId: user.uid,
      title: _title.text.trim(),
      price: double.parse(_price.text),
      description: _desc.text.trim(),
      images: [],
      timestamp: DateTime.now(),
    );

    try {
      final pid = await _fs.createPost(draft);

      final urls = <String>[];
      for (final img in _imgs) {
        urls.add(await _st.uploadPostImage(user.uid, pid, img));
      }

      await _fs.updatePostImages(pid, urls);

      if (mounted) Navigator.pop(context, true);
    } catch (e) {
      _snack('Failed: $e');
    }
  }

  void _snack(String msg) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('New Post'),
          actions: [
            IconButton(icon: const Icon(Icons.check), onPressed: _submit),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _form,
            child: Column(children: [
              TextFormField(
                controller: _title,
                decoration: const InputDecoration(labelText: 'Title'),
                validator: (v) => v!.isEmpty ? 'Required' : null,
              ),
              TextFormField(
                controller: _price,
                decoration: const InputDecoration(labelText: 'Price'),
                keyboardType: TextInputType.number,
                validator: (v) =>
                    double.tryParse(v!) == null ? 'Enter number' : null,
              ),
              TextFormField(
                controller: _desc,
                decoration: const InputDecoration(labelText: 'Description'),
                validator: (v) => v!.isEmpty ? 'Required' : null,
              ),
              const SizedBox(height: 12),
              Wrap(
                spacing: 8,
                children: [
                  ..._imgs.asMap().entries.map((e) => Stack(
                        alignment: Alignment.topRight,
                        children: [
                          Image.file(File(e.value.path),
                              width: 80, height: 80, fit: BoxFit.cover),
                          GestureDetector(
                            onTap: () => setState(() => _imgs.removeAt(e.key)),
                            child: Container(
                                color: Colors.black54,
                                child: const Icon(Icons.close,
                                    size: 18, color: Colors.white)),
                          )
                        ],
                      )),
                  if (_imgs.length < 4)
                    IconButton(
                        icon: const Icon(Icons.add_a_photo), onPressed: _pick),
                ],
              ),
              const Spacer(),
              ElevatedButton(onPressed: _submit, child: const Text('Post')),
            ]),
          ),
        ),
      );
}
