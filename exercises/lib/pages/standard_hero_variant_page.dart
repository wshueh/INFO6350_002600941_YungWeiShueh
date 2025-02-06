import 'package:flutter/material.dart';
import '../widgets/photo_hero.dart';

class StandardHeroVariantPage extends StatelessWidget {
  const StandardHeroVariantPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Standard Hero Variant'),
      ),
      body: Center(
        child: PhotoHero(
          photo: 'images/molly.jpg',
          width: 100.0,
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute<void>(
              builder: (context) {
                return Scaffold(
                  appBar: AppBar(title: const Text('Variant Page')),
                  body: Center(
                    child: PhotoHero(
                      photo: 'images/molly.jpg',
                      width: 300.0,
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ),
                );
              },
            ));
          },
        ),
      ),
    );
  }
}
