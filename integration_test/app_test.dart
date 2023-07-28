import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:counter_app/main.dart';

void main() {
  final binding = IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  group('end-to-end test', () {
    testWidgets('tap on the floating action button 1 time, verify counter',
        (tester) async {
      await tapAndCheck(binding, tester, 1);
    });
    testWidgets('tap on the floating action button 2 times, verify counter',
        (tester) async {
      await tapAndCheck(binding, tester, 2);
    });
  });
}

Future<void> tapAndCheck(IntegrationTestWidgetsFlutterBinding binding,
    WidgetTester tester, int tapCount) async {
  // Load app widget.
  await tester.pumpWidget(const MyApp());

  // Verify the counter starts at 0.
  expect(find.text('0'), findsOneWidget);

  // Finds the floating action button to tap on.
  final Finder fab = find.byTooltip('Increment');

  for (var i = 0; i < tapCount; i++) {
    // Emulate a tap on the floating action button.
    await tester.tap(fab);
  }

  // Trigger a frame.
  await tester.pumpAndSettle();

  // Verify the counter increments by 1.
  expect(find.text(tapCount.toString()), findsOneWidget);

  // Take screenshot (not for image comparsion but for documentation).
  await binding.takeScreenshot('test-screenshot $tapCount');

  // Wait a bit to observe the result while the tests are running.
  await Future.delayed(const Duration(seconds: 2));
}
