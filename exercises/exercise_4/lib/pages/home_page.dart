import 'package:flutter/material.dart';
import 'standard_hero_animation_page.dart';
import 'standard_hero_variant_page.dart';
import 'basic_radial_hero_animation_page.dart';
import 'radial_hero_animate_rect_clip_page.dart';
import 'radial_hero_slide_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hero Animations Demo'),
      ),
      body: ListView(
        children: [
          _buildListTile(
            context,
            title: 'Standard Hero Animation',
            page: const StandardHeroAnimationPage(),
          ),
          _buildListTile(
            context,
            title: 'Standard Hero Variant',
            page: const StandardHeroVariantPage(),
          ),
          _buildListTile(
            context,
            title: 'Basic Radial Hero Animation',
            page: const BasicRadialHeroAnimationPage(),
          ),
          _buildListTile(
            context,
            title: 'Radial Hero Animate Rect Clip',
            page: const RadialHeroAnimateRectClipPage(),
          ),
          _buildListTile(
            context,
            title: 'Radial Hero Slide',
            page: const RadialHeroSlidePage(),
          ),
        ],
      ),
    );
  }

  Widget _buildListTile(BuildContext context,
      {required String title, required Widget page}) {
    return ListTile(
      title: Text(title),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => page),
        );
      },
    );
  }
}
