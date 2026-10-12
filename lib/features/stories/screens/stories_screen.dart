import 'package:flutter/material.dart';

class StoriesScreen extends StatelessWidget {
  const StoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final stories = [
      {
        'title': 'Stories of Deities',
        'subtitle': 'Discover stories that explore the lives, symbolism, and significance of Hindu deities.',
        // Reusing deities image since we didn't generate all new ones
        'image': 'assets/images/deities.jpg',
        'chapters': 3,
      },
      {
        'title': 'Epic Stories',
        'subtitle': 'Explore memorable tales and key events from ancient epics.',
        'image': 'assets/images/stories.jpg', // Placeholder for now
        'chapters': 3,
      },
      {
        'title': 'Legends & Folklore',
        'subtitle': 'Discover traditional stories passed down through generations across India.',
        'image': 'assets/images/temples.jpg', // Placeholder
        'chapters': 3,
      },
      {
        'title': 'Stories of Sages',
        'subtitle': 'Learn about the lives, teachings, and journeys of influential sages and saints.',
        'image': 'assets/images/puranas.png', // Placeholder
        'chapters': 3,
      },
      {
        'title': 'Tales of Dharma',
        'subtitle': 'Explore stories that reflect questions of duty, choices, and righteous action.',
        'image': 'assets/images/ramayana.png',
        'chapters': 3,
      },
      {
        'title': 'Stories of Devotion',
        'subtitle': 'Discover inspiring stories of faith, love, and devotion.',
        'image': 'assets/images/bhagavad_gita.png',
        'chapters': 3,
      },
    ];

    final screenWidth = MediaQuery.of(context).size.width;
    final headerHeight = screenWidth * (9 / 16); // 16:9 aspect ratio (width:height)

    return Scaffold(
      backgroundColor: Colors.black, // Dark background for the edges
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: headerHeight,
            floating: false,
            pinned: true,
            backgroundColor: Colors.black, // Dark color when collapsed
            elevation: 0,
            leading: Center(
              child: Container(
                margin: const EdgeInsets.only(left: 16),
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.brown.shade800.withOpacity(0.6),
                  shape: BoxShape.circle,
                ),
                child: IconButton(
                  padding: EdgeInsets.zero,
                  icon: const Icon(Icons.arrow_back, color: Colors.white, size: 20),
                  onPressed: () => Navigator.pop(context),
                ),
              ),
            ),
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                fit: StackFit.expand,
                children: [
                  Image.asset(
                    'assets/images/stories.jpg', // Stories background image
                    fit: BoxFit.cover,
                    alignment: const Alignment(0, -0.3),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.black.withOpacity(0.4),
                          Colors.black.withOpacity(0.7),
                        ],
                      ),
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(height: 60),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(width: 30, height: 1, color: Colors.amber.shade200),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 12.0),
                            child: Icon(Icons.local_florist, color: Colors.amber.shade200, size: 24),
                          ),
                          Container(width: 30, height: 1, color: Colors.amber.shade200),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Stories',
                        style: TextStyle(
                          fontSize: 48,
                          fontWeight: FontWeight.w600,
                          color: Colors.amber.shade100, // Golden text
                          fontFamily: 'Times New Roman', // Or any elegant serif font available
                          letterSpacing: 1.2,
                          shadows: const [
                            Shadow(
                              offset: Offset(0, 2),
                              blurRadius: 4.0,
                              color: Colors.black54,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 12),
                      const Text(
                        'Explore timeless tales and legends\nof Sanatana Dharma',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.white,
                          fontWeight: FontWeight.w400,
                          letterSpacing: 0.5,
                          height: 1.5,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16), // Margins on left and right
              child: Container(
                decoration: const BoxDecoration(
                  color: Color(0xFFFAF8F5), // Light cream color for the list card
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                child: ListView.builder(
                  padding: const EdgeInsets.fromLTRB(16, 24, 16, 24),
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: stories.length,
                  itemBuilder: (context, index) {
                    final item = stories[index];
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 24),
                      child: StoryCard(
                        title: item['title'] as String,
                        subtitle: item['subtitle'] as String,
                        imageUrl: item['image'] as String,
                        chapters: item['chapters'] as int,
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class StoryCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final String imageUrl;
  final int chapters;

  const StoryCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.imageUrl,
    required this.chapters,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        image: DecorationImage(
          image: AssetImage(imageUrl),
          fit: BoxFit.cover,
        ),
      ),
      clipBehavior: Clip.hardEdge,
      child: Stack(
        children: [
          // Top right chapters badge
          Positioned(
            top: 16,
            right: 16,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.5),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.menu_book, color: Color(0xFFFFC107), size: 14),
                  const SizedBox(width: 6),
                  Text(
                    '$chapters chapters',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Bottom overlay
          Positioned(
            bottom: 16,
            left: 16,
            right: 16,
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.6),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          title,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          subtitle,
                          style: const TextStyle(
                            color: Colors.white70,
                            fontSize: 13,
                            height: 1.4,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 16),
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: const BoxDecoration(
                      color: Color(0xFFFFC107), // Yellow
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.arrow_forward,
                      color: Colors.black,
                      size: 20,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
