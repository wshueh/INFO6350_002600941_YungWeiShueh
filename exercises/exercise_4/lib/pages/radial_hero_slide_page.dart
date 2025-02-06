import 'package:flutter/material.dart';

class RadialHeroSlidePage extends StatelessWidget {
  const RadialHeroSlidePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Radial Hero Slide'),
      ),
      body: Center(
        child: GestureDetector(
          onTap: () {
            Navigator.of(context).push(PageRouteBuilder(
              transitionDuration: const Duration(milliseconds: 700),
              pageBuilder: (context, animation, secondaryAnimation) {
                return RadialHeroDetailPage(animation: animation);
              },
            ));
          },
          child: Hero(
            tag: 'radial-slide',
            child: ClipOval(
              child: Image.asset(
                'images/theo.jpg',
                width: 150.0,
                height: 150.0,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class RadialHeroDetailPage extends StatelessWidget {
  final Animation<double> animation;

  const RadialHeroDetailPage({super.key, required this.animation});

  @override
  Widget build(BuildContext context) {
    final fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: animation,
        curve: const Interval(0.0, 0.5, curve: Curves.easeIn),
      ),
    );

    return Scaffold(
      appBar: AppBar(title: const Text('Radial Hero Detail')),
      body: Center(
        child: GestureDetector(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: Hero(
            tag: 'radial-slide',
            child: FadeTransition(
              opacity: fadeAnimation,
              child: ClipOval(
                child: Image.asset(
                  'images/theo.jpg',
                  width: 480.0,
                  height: 480.0,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
