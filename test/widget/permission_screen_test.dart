import 'package:color_blind_filter/screens/permission_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('PermissionScreen', () {
    testWidgets('shows loading indicator initially', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: PermissionScreen(),
        ),
      );

      // Initially shows loading
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    // Note: Full permission flow testing requires mocking permission_handler
    // or running on a real device. The following tests verify UI structure.

    testWidgets('has correct widget structure', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: PermissionScreen(),
        ),
      );

      // Verify the widget is a StatefulWidget
      expect(find.byType(PermissionScreen), findsOneWidget);
      expect(find.byType(Scaffold), findsOneWidget);
    });
  });
}
