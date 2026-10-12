import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../widgets/shloka_card.dart';
import '../widgets/category_grid.dart';
import '../widgets/continue_journey_card.dart';
import '../widgets/upcoming_festivals_list.dart';
import '../widgets/discover_list.dart';
import '../widgets/custom_bottom_nav_bar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F8F8), // Light background
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: false,
        automaticallyImplyLeading: false,
        title: RichText(
          text: const TextSpan(
            text: 'Hii, ',
            style: TextStyle(
              color: Colors.black,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
            children: [
              TextSpan(
                text: 'Sai',
                style: TextStyle(
                  color: AppColors.accentYellow,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed('/search');
            },
            icon: const Icon(Icons.search, color: Colors.black87),
            style: IconButton.styleFrom(
              backgroundColor: Colors.white,
              shape: const CircleBorder(),
            ),
          ),
          IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed('/notifications');
            },
            icon: const Icon(Icons.notifications_none, color: Colors.black87),
            style: IconButton.styleFrom(
              backgroundColor: Colors.white,
              shape: const CircleBorder(),
            ),
          ),
          const SizedBox(width: 16),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              SizedBox(height: 16),
              ShlokaCard(),
              SizedBox(height: 24),
              CategoryGrid(),
              SizedBox(height: 24),
              SectionHeader(title: 'Continue Journey', actionText: 'View Path'),
              SizedBox(height: 12),
              ContinueJourneyCard(),
              SizedBox(height: 24),
              SectionHeader(title: 'Upcoming Festivals', actionText: 'View All'),
              SizedBox(height: 12),
              UpcomingFestivalsList(),
              SizedBox(height: 24),
              SectionHeader(title: 'Discover'),
              SizedBox(height: 12),
              DiscoverList(),
              SizedBox(height: 100), // padding for bottom nav
            ],
          ),
        ),
      ),
      extendBody: true,
      bottomNavigationBar: const CustomBottomNavBar(),
    );
  }
}

class SectionHeader extends StatelessWidget {
  final String title;
  final String? actionText;

  const SectionHeader({super.key, required this.title, this.actionText});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        if (actionText != null)
          GestureDetector(
            onTap: () {},
            child: Row(
              children: [
                Text(
                  actionText!,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.black54,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(width: 4),
                const Icon(Icons.arrow_forward_ios, size: 12, color: Colors.black54),
              ],
            ),
          )
      ],
    );
  }
}
