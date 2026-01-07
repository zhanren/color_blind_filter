import 'package:color_blind_filter/widgets/settings_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('SettingsButton', () {
    testWidgets('displays settings icon', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SettingsButton(
              onPressed: () {},
            ),
          ),
        ),
      );

      expect(find.byIcon(Icons.settings), findsOneWidget);
    });

    testWidgets('calls onPressed when tapped', (tester) async {
      var tapped = false;
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SettingsButton(
              onPressed: () => tapped = true,
            ),
          ),
        ),
      );

      await tester.tap(find.byType(SettingsButton));
      await tester.pump();

      expect(tapped, isTrue);
    });
  });
}
