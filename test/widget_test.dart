// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

// import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:landlord_portal/features/splash_screen/splash_screen.dart';

// import 'package:landlord_portal/main.dart';

void main() {
  // testWidgets('Counter increments smoke test', (WidgetTester tester) async {
  //   // Build our app and trigger a frame.
  //   await tester.pumpWidget(const MyApp());

  //   // Verify that our counter starts at 0.
  //   expect(find.text('0'), findsOneWidget);
  //   expect(find.text('1'), findsNothing);

  //   // Tap the '+' icon and trigger a frame.
  //   await tester.tap(find.byIcon(Icons.add));
  //   await tester.pump();

  //   // Verify that our counter has incremented.
  //   expect(find.text('0'), findsNothing);
  //   expect(find.text('1'), findsOneWidget);
  // });
  // test("Onboarded users should not go through onboarding screen", () {

  // });
  group("onboarding", () {
    testWidgets("Should show splash screen", (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(
        home: SplashScreen(),
      ));

      await tester.pumpAndSettle(const Duration(seconds: 3));

      await tester.runAsync(() async {
        final keyoneLogo = find.byWidgetPredicate((widget) =>
            widget is Image &&
            widget.image is AssetImage &&
            (widget.image as AssetImage).assetName ==
                'assets/images/keyone_logo.png');

        expect(keyoneLogo, findsOneWidget);
      });

      await tester.binding.delayed(
          const Duration(seconds: 2)); // Manually trigger the pending Timer
    });
  });
}
