import 'package:flutter/material.dart';

class FullImageView extends StatelessWidget {
  final String imageUrl;
  FullImageView({required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(child: Image.network(imageUrl)),
    );
  }
}
