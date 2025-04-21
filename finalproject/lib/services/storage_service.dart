import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

class StorageService {
  final _storage = FirebaseStorage.instance;

  Future<String> uploadPostImage(
      String userId, String postId, XFile img) async {
    final ref = _storage.ref(
        'posts/$userId/$postId/${DateTime.now().millisecondsSinceEpoch}.jpg');
    await ref.putFile(File(img.path));
    return ref.getDownloadURL();
  }

  Future<void> deleteImages(List<String> urls) async {
    for (final url in urls) {
      try {
        await _storage.refFromURL(url).delete();
      } catch (_) {/* Ignore if the file does not exist */}
    }
  }
}
