import 'package:flutter_test/flutter_test.dart';
import 'package:aumniverse/main.dart';

void main() {
  testWidgets('AumniverseApp loads OnboardingScreen on startup', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const AumniverseApp());

    expect(find.text('Discover Ancient\nWisdom'), findsOneWidget);
    expect(find.text('Skip'), findsOneWidget);
  });
}
