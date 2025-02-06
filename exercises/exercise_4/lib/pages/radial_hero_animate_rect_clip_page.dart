import 'package:flutter/material.dart';

class RadialHeroAnimateRectClipPage extends StatelessWidget {
  const RadialHeroAnimateRectClipPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Radial Hero Animate Rect Clip'),
      ),
      body: Center(
        child: GestureDetector(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute<void>(
              builder: (context) {
                return Scaffold(
                  appBar: AppBar(title: const Text('Animate Rect Detail')),
                  body: Container(
                    color: Colors.orangeAccent,
                    child: Center(
                      child: Hero(
                        tag: 'radial-animate',
                        child: ClipOval(
                          child: Image.asset(
                            'images/theo.jpg',
                            width: 160.0 * 2,
                            height: 160.0 * 2,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ));
          },
          child: Hero(
            tag: 'radial-animate',
            child: ClipOval(
              child: Image.asset(
                'images/theo.jpg',
                width: 40.0 * 2,
                height: 40.0 * 2,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
