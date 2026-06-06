import 'package:flutter_test/flutter_test.dart';
import 'package:paypatch/main.dart';

void main() {
  testWidgets('PayPatchApp smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const PayPatchApp());

    // Verify that the splash screen text containing 'Pay' is rendered.
    expect(find.textContaining('Pay'), findsWidgets);
  });
}
