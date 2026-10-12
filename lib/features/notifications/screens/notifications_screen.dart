import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black, size: 20),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          'Notifications',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.tune, color: Colors.black),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),
              Center(
                child: RichText(
                  text: const TextSpan(
                    text: 'You have ',
                    style: TextStyle(color: Colors.black87, fontSize: 13),
                    children: [
                      TextSpan(
                        text: '3 Notifications',
                        style: TextStyle(color: AppColors.accentYellow, fontWeight: FontWeight.w600),
                      ),
                      TextSpan(text: ' today.'),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),
              const Text(
                'Today',
                style: TextStyle(
                  color: AppColors.accentYellow,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 16),
              _buildNotificationItem(
                text: 'Diwali is coming in 15 days. Check rituals & all.',
                color: const Color(0xFFD6A054),
                isUnread: true,
                isToday: true,
              ),
              const Divider(height: 32, color: Color(0xFFF0F0F0)),
              _buildNotificationItem(
                text: 'You forgot to read today\'s Quote of the day. ',
                actionText: 'Read Now',
                color: const Color(0xFFE53935),
                isUnread: true,
                isToday: true,
              ),
              const Divider(height: 32, color: Color(0xFFF0F0F0)),
              _buildNotificationItem(
                text: 'Do you know why you light dia infront of bhagwaan Vishnu?',
                color: const Color(0xFF424242),
                isUnread: true,
                isToday: true,
              ),
              const SizedBox(height: 32),
              const Text(
                'This Week',
                style: TextStyle(
                  color: AppColors.accentYellow,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 16),
              _buildNotificationItem(
                text: 'Diwali is coming in 15 days. Check rituals & all.',
                color: const Color(0xFFD6A054),
              ),
              const Divider(height: 32, color: Color(0xFFF0F0F0)),
              _buildNotificationItem(
                text: 'You forgot to read today\'s Quote of the day. ',
                actionText: 'Read Now',
                color: const Color(0xFFE53935),
              ),
              const Divider(height: 32, color: Color(0xFFF0F0F0)),
              _buildNotificationItem(
                text: 'Do you know why you light dia infront of bhagwaan Vishnu?',
                color: const Color(0xFF424242),
              ),
              const Divider(height: 32, color: Color(0xFFF0F0F0)),
              _buildNotificationItem(
                text: 'You forgot to read today\'s Quote of the day. ',
                actionText: 'Read Now',
                color: const Color(0xFFE53935),
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNotificationItem({
    required String text,
    String? actionText,
    required Color color,
    bool isUnread = false,
    bool isToday = false,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        if (isUnread)
          Container(
            width: 4,
            height: 4,
            margin: const EdgeInsets.only(right: 8),
            decoration: const BoxDecoration(
              color: AppColors.accentYellow,
              shape: BoxShape.rectangle,
            ),
          )
        else
          const SizedBox(width: 12),
        Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
          child: const Center(
            child: Icon(Icons.image, color: Colors.white, size: 24),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: RichText(
            text: TextSpan(
              text: text,
              style: const TextStyle(
                color: Colors.black87,
                fontSize: 13,
                height: 1.4,
              ),
              children: [
                if (actionText != null)
                  TextSpan(
                    text: actionText,
                    style: const TextStyle(
                      color: AppColors.accentYellow,
                      fontWeight: FontWeight.w600,
                      decoration: TextDecoration.underline,
                    ),
                  ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
