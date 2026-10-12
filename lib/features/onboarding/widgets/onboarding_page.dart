import 'package:flutter/material.dart';

import '../models/onboarding_model.dart';
import '../../../core/constants/app_constants.dart';

/// Individual text card widget for the onboarding screen.
class OnboardingTextCard extends StatelessWidget {
  final OnboardingModel slide;

  const OnboardingTextCard({super.key, required this.slide});

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final isCompact = mediaQuery.size.height < 700;

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppConstants.paddingLarge,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Title
          Text(
            slide.title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.w800,
              color: const Color(0xFF1D1B20),
              fontSize: isCompact ? 26 : 30,
              height: 1.22,
              letterSpacing: -0.5,
            ),
          ),

          SizedBox(height: isCompact ? 10 : 14),

          // Description
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 320),
            child: Text(
              slide.description,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: const Color(0xFF5E5C56),
                height: 1.5,
                fontSize: isCompact ? 14 : 15,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
