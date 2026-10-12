import 'package:flutter/material.dart';

import '../../scriptures/screens/scriptures_screen.dart';
import '../../stories/screens/stories_screen.dart';

class CategoryGrid extends StatelessWidget {
  const CategoryGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisSpacing: 12,
      mainAxisSpacing: 12,
      childAspectRatio: 1.6,
      children: [
        CategoryItem(
          title: 'Scriptures',
          color: Color(0xFFF27B50),
          imageUrl: 'assets/images/scriptures.jpg',
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const ScripturesScreen()),
            );
          },
        ),
        CategoryItem(
          title: 'Stories',
          color: Color(0xFF6B7280),
          imageUrl: 'assets/images/stories.jpg',
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const StoriesScreen()),
            );
          },
        ),
        CategoryItem(
          title: 'Deities',
          color: Color(0xFF0EA5E9),
          imageUrl: 'assets/images/deities.jpg',
        ),
        CategoryItem(
          title: 'Temples',
          color: Color(0xFF94A3B8),
          imageUrl: 'assets/images/temples.jpg',
        ),
      ],
    );
  }
}

class CategoryItem extends StatelessWidget {
  final String title;
  final Color color;
  final String imageUrl;
  final VoidCallback? onTap;

  const CategoryItem({
    super.key,
    required this.title,
    required this.color,
    required this.imageUrl,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(12),
      ),
      clipBehavior: Clip.hardEdge,
      child: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(imageUrl, fit: BoxFit.cover),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            margin: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.3),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Positioned(
            bottom: 8,
            right: 8,
            child: Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.2),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.arrow_forward, size: 12, color: Colors.white),
            ),
          )
        ],
      ),
    ));
  }
}
