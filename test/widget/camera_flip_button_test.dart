import 'package:color_blind_filter/widgets/camera_flip_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('CameraFlipButton', () {
    testWidgets('displays flip camera icon', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CameraFlipButton(
              onPressed: () {},
            ),
          ),
        ),
      );

      expect(find.byIcon(Icons.flip_camera_ios), findsOneWidget);
    });

    testWidgets('calls onPressed when tapped', (tester) async {
      var tapped = false;
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CameraFlipButton(
              onPressed: () => tapped = true,
            ),
          ),
        ),
      );

      await tester.tap(find.byType(CameraFlipButton));
      await tester.pump();

      expect(tapped, isTrue);
    });

    testWidgets('shows loading indicator when isLoading', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CameraFlipButton(
              onPressed: () {},
              isLoading: true,
            ),
          ),
        ),
      );

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
      expect(find.byIcon(Icons.flip_camera_ios), findsNothing);
    });

    testWidgets('does not call onPressed when isLoading', (tester) async {
      var tapped = false;
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CameraFlipButton(
              onPressed: () => tapped = true,
              isLoading: true,
            ),
          ),
        ),
      );

      await tester.tap(find.byType(CameraFlipButton));
      await tester.pump();

      expect(tapped, isFalse);
    });
  });
}
