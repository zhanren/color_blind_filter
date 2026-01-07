import 'package:color_blind_filter/models/view_mode.dart';
import 'package:color_blind_filter/widgets/view_toggle_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('ViewToggleButton', () {
    testWidgets('renders icon for current mode', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ViewToggleButton(
              currentMode: ViewMode.fullScreen,
              onToggle: () {},
            ),
          ),
        ),
      );

      // In full screen mode, shows view_column icon (to switch to split)
      expect(find.byIcon(Icons.view_column), findsOneWidget);
    });

    testWidgets('renders different icon for split view mode', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ViewToggleButton(
              currentMode: ViewMode.splitView,
              onToggle: () {},
            ),
          ),
        ),
      );

      // In split view mode, shows fullscreen icon (to switch to full)
      expect(find.byIcon(Icons.fullscreen), findsOneWidget);
    });

    testWidgets('triggers onToggle callback when tapped', (tester) async {
      var toggled = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ViewToggleButton(
              currentMode: ViewMode.fullScreen,
              onToggle: () => toggled = true,
            ),
          ),
        ),
      );

      await tester.tap(find.byType(ViewToggleButton));
      await tester.pumpAndSettle();

      expect(toggled, isTrue);
    });

    testWidgets('has circular shape', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ViewToggleButton(
              currentMode: ViewMode.fullScreen,
              onToggle: () {},
            ),
          ),
        ),
      );

      final container = tester.widget<Container>(
        find.descendant(
          of: find.byType(ViewToggleButton),
          matching: find.byType(Container).first,
        ),
      );

      final decoration = container.decoration as BoxDecoration?;
      expect(decoration?.shape, BoxShape.circle);
    });
  });
}
