import 'package:color_blind_filter/screens/camera_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('CameraScreen', () {
    testWidgets('shows loading indicator while initializing', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: CameraScreen(),
        ),
      );

      // Should show loading indicator initially
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('displays mode label and switcher', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: CameraScreen(),
        ),
      );

      // Mode label and switcher both display "Protanopia"
      expect(find.text('Protanopia'), findsAtLeast(1));
      // Short name should appear in both label and switcher
      expect(find.text('Red-blind'), findsAtLeast(1));
    });

    testWidgets('has stack layout for overlays', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: CameraScreen(),
        ),
      );

      // Should have at least one Stack for overlays
      expect(find.byType(Stack), findsWidgets);
    });
  });
}
