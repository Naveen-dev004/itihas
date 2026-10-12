/// Onboarding slide data model.
class OnboardingModel {
  final String title;
  final String description;
  final String? imageAsset;

  const OnboardingModel({
    required this.title,
    required this.description,
    this.imageAsset,
  });
}
