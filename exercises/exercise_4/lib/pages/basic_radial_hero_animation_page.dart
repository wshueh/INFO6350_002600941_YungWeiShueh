import 'package:flutter/material.dart';

class BasicRadialHeroAnimationPage extends StatelessWidget {
  const BasicRadialHeroAnimationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Basic Radial Hero Animation'),
      ),
      body: Center(
        child: GestureDetector(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute<void>(
              builder: (context) {
                return Scaffold(
                  appBar: AppBar(title: const Text('Radial Detail')),
                  body: Center(
                    child: Hero(
                      tag: 'radial-flutter',
                      child: ClipOval(
                        child: Image.asset(
                          'images/theo.jpg',
                          width: 128.0 * 2,
                          height: 128.0 * 2,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ));
          },
          child: Hero(
            tag: 'radial-flutter',
            child: ClipOval(
              child: Image.asset(
                'images/theo.jpg',
                width: 32.0 * 2,
                height: 32.0 * 2,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
