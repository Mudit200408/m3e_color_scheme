import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:example/main.dart';
import 'package:example/screens/m3e_card_screen.dart';

void main() {
  testWidgets('Simulate back swipe gesture to catch animation exceptions', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());
    await tester.pumpAndSettle();

    final BuildContext context = tester.element(find.byType(ExampleHomePage));

    print('Pushing screen...');
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const M3ECardScreen()),
    );
    await tester.pumpAndSettle();

    print('Simulating back swipe gesture...');
    // Start gesture near the left edge and drag right to trigger back navigation swipe
    final gesture = await tester.startGesture(const Offset(5.0, 300.0));
    await gesture.moveBy(const Offset(100.0, 0.0));
    await tester.pump();
    await gesture.moveBy(const Offset(200.0, 0.0));
    await tester.pump();
    await gesture.up();
    await tester.pumpAndSettle();

    print('Back swipe completed!');
  });
}
