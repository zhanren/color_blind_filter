import 'package:color_blind_filter/widgets/capture_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('CaptureButton', () {
    testWidgets('renders camera icon', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CaptureButton(
              onPressed: () {},
            ),
          ),
        ),
      );

      expect(find.byIcon(Icons.camera_alt), findsOneWidget);
    });

    testWidgets('triggers onPressed callback when tapped', (tester) async {
      var pressed = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CaptureButton(
              onPressed: () => pressed = true,
            ),
          ),
        ),
      );

      await tester.tap(find.byType(CaptureButton));
      await tester.pumpAndSettle();

      expect(pressed, isTrue);
    });

    testWidgets('shows loading indicator when isCapturing is true',
        (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CaptureButton(
              onPressed: () {},
              isCapturing: true,
            ),
          ),
        ),
      );

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
      expect(find.byIcon(Icons.camera_alt), findsNothing);
    });

    testWidgets('has circular shape', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CaptureButton(
              onPressed: () {},
            ),
          ),
        ),
      );

      final container = tester.widget<Container>(
        find.descendant(
          of: find.byType(CaptureButton),
          matching: find.byType(Container).first,
        ),
      );

      final decoration = container.decoration as BoxDecoration?;
      expect(decoration?.shape, BoxShape.circle);
    });
  });
}
