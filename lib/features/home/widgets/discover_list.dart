import 'package:flutter/material.dart';

class DiscoverList extends StatelessWidget {
  const DiscoverList({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      child: ListView(
        scrollDirection: Axis.horizontal,
        clipBehavior: Clip.none,
        children: const [
          DiscoverCard(
            title: 'Story of\nMountain',
            imageUrl: 'assets/images/mountain.png',
            backgroundColor: Color(0xFFFFF0E0),
          ),
          SizedBox(width: 16),
          DiscoverCard(
            title: 'Story of the\nJyotirlingas',
            imageUrl: 'assets/images/jyotirlinga.png',
            backgroundColor: Color(0xFFF3F4F6),
          ),
        ],
      ),
    );
  }
}

class DiscoverCard extends StatelessWidget {
  final String title;
  final String imageUrl;
  final Color backgroundColor;

  const DiscoverCard({
    super.key,
    required this.title,
    required this.imageUrl,
    required this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 220,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
          ),
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: backgroundColor,
              borderRadius: BorderRadius.circular(8),
            ),
            // child: Image.asset(imageUrl, fit: BoxFit.cover),
          ),
        ],
      ),
    );
  }
}
