import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:aumniverse/features/onboarding/screens/onboarding_screen.dart';

void main() {
  testWidgets(
    'OnboardingScreen renders title, description, skip and next button',
    (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(home: OnboardingScreen()));

      // Verify Title and Description
      expect(find.text('Discover Ancient\nWisdom'), findsOneWidget);
      expect(
        find.text(
          'Explore ancient scriptures, philosophy, history, and cultural heritage in one place.',
        ),
        findsOneWidget,
      );

      // Verify Skip and Next Buttons
      expect(find.text('Skip'), findsOneWidget);
      expect(find.byIcon(Icons.arrow_forward_rounded), findsOneWidget);
    },
  );

  testWidgets('Tapping Next moves to next slide', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: OnboardingScreen()));

    // Tap Next Button
    await tester.tap(find.byIcon(Icons.arrow_forward_rounded));
    await tester.pumpAndSettle();

    // Verify Slide 2 Content
    expect(find.text('Interactive Learning'), findsOneWidget);
  });
}
