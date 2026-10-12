import 'package:flutter/material.dart';

class UpcomingFestivalsList extends StatelessWidget {
  const UpcomingFestivalsList({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 180,
      child: ListView(
        scrollDirection: Axis.horizontal,
        clipBehavior: Clip.none,
        children: const [
          FestivalCard(
            title: 'Diwali',
            date: '10-15 Aug',
            description: 'Diwali, is celebrated as the vibrant festival of lights by cleaning homes, lighting clay lamps, praying to deities, sharing sweets, and bursting fireworks to symbolize good over evil.',
            color: Color(0xFFD6A054),
          ),
          SizedBox(width: 16),
          FestivalCard(
            title: 'Holi',
            date: '25 Mar',
            description: 'Holi is a vibrant festival known as the festival of colors. It celebrates the triumph of good over evil.',
            color: Color(0xFFC7839F),
          ),
        ],
      ),
    );
  }
}

class FestivalCard extends StatelessWidget {
  final String title;
  final String date;
  final String description;
  final Color color;

  const FestivalCard({
    super.key,
    required this.title,
    required this.date,
    required this.description,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 260,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(16),
      ),
      clipBehavior: Clip.hardEdge,
      child: Stack(
        children: [
          // If you have assets, add background image here
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.black.withOpacity(0.1),
                  Colors.black.withOpacity(0.6),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Text(
                          title,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(width: 4),
                        const Icon(Icons.arrow_forward_ios, size: 12, color: Colors.white70),
                      ],
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.4),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        date,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                Text(
                  description,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    height: 1.3,
                  ),
                  maxLines: 4,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
