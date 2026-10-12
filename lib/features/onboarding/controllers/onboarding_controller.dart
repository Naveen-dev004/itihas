import 'package:flutter/material.dart';

import '../models/onboarding_model.dart';
import '../services/onboarding_service.dart';

/// Business logic controller for the Onboarding feature.
class OnboardingController extends ChangeNotifier {
  final OnboardingService _service;

  int _currentIndex = 0;

  OnboardingController({OnboardingService? service})
    : _service = service ?? OnboardingService();

  int get currentIndex => _currentIndex;
  bool get isLastPage => _currentIndex == slides.length - 1;

  final List<OnboardingModel> slides = const [
    OnboardingModel(
      title: 'Discover Ancient\nWisdom',
      description: 'Explore ancient scriptures, philosophy, history, and cultural heritage in one place.',
      imageAsset: 'assets/images/onboarding_1_illustration.png',
    ),
    OnboardingModel(
      title: 'Interactive Learning',
      description: 'Engage with structured courses, audio recitations, and interactive translations.',
      imageAsset: 'assets/images/onboarding_2_illustration.png',
    ),
    OnboardingModel(
      title: 'Preserve & Connect',
      description: 'Connect with scholars, share insights, and preserve eternal knowledge for generations.',
      imageAsset: 'assets/images/onboarding_3_illustration.png',
    ),
  ];

  void onPageChanged(int index) {
    _currentIndex = index;
    notifyListeners();
  }

  bool _isAnimating = false;

  void nextPage(BuildContext context) async {
    if (_isAnimating) return;

    if (isLastPage) {
      completeOnboarding(context);
      return;
    }

    _isAnimating = true;
    _currentIndex = (_currentIndex + 1) % slides.length;
    notifyListeners();

    await Future.delayed(const Duration(milliseconds: 500));
    _isAnimating = false;
  }

  void previousPage(BuildContext context) async {
    if (_isAnimating) return;

    _isAnimating = true;
    _currentIndex = (_currentIndex - 1 + slides.length) % slides.length;
    notifyListeners();

    await Future.delayed(const Duration(milliseconds: 500));
    _isAnimating = false;
  }

  void skip(BuildContext context) {
    completeOnboarding(context);
  }

  Future<void> completeOnboarding(BuildContext context) async {
    await _service.markOnboardingComplete();
    if (context.mounted) {
      Navigator.of(context).pushReplacementNamed('/login');
    }
  }

  @override
  void dispose() {
    super.dispose();
  }
}
