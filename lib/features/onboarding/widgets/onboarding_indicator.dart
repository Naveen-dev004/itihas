import 'package:flutter/material.dart';

import '../../../core/constants/app_colors.dart';

/// Page indicator dots widget for onboarding flow.
class OnboardingIndicator extends StatelessWidget {
  final int count;
  final int currentIndex;

  const OnboardingIndicator({
    super.key,
    required this.count,
    required this.currentIndex,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(count, (index) {
        final isSelected = index == currentIndex;
        return AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeInOut,
          margin: const EdgeInsets.symmetric(horizontal: 4.0),
          height: 8.0,
          width: isSelected ? 24.0 : 8.0,
          decoration: BoxDecoration(
            color: isSelected
                ? const Color(0xFFF5B800)
                : const Color(0xFF2E2C29),
            borderRadius: BorderRadius.circular(4.0),
          ),
        );
      }),
    );
  }
}
