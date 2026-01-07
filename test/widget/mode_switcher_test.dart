import 'package:color_blind_filter/models/filter_mode.dart';
import 'package:color_blind_filter/widgets/mode_switcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('ModeSwitcher', () {
    testWidgets('displays 4 mode buttons', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ModeSwitcher(
              currentMode: FilterMode.protanopia,
              onModeChanged: (_) {},
            ),
          ),
        ),
      );

      // Check all 4 filter names are displayed
      expect(find.text('Protanopia'), findsOneWidget);
      expect(find.text('Deuteranopia'), findsOneWidget);
      expect(find.text('Tritanopia'), findsOneWidget);
      expect(find.text('Achromatopsia'), findsOneWidget);
    });

    testWidgets('displays short names for each mode', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ModeSwitcher(
              currentMode: FilterMode.protanopia,
              onModeChanged: (_) {},
            ),
          ),
        ),
      );

      expect(find.text('Red-blind'), findsOneWidget);
      expect(find.text('Green-blind'), findsOneWidget);
      expect(find.text('Blue-blind'), findsOneWidget);
      expect(find.text('Monochrome'), findsOneWidget);
    });

    testWidgets('tapping button triggers onModeChanged callback',
        (tester) async {
      FilterMode? selectedMode;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ModeSwitcher(
              currentMode: FilterMode.protanopia,
              onModeChanged: (mode) => selectedMode = mode,
            ),
          ),
        ),
      );

      // Tap on Deuteranopia
      await tester.tap(find.text('Deuteranopia'));
      await tester.pumpAndSettle();

      expect(selectedMode, FilterMode.deuteranopia);
    });

    testWidgets('tapping different buttons triggers correct callbacks',
        (tester) async {
      final selectedModes = <FilterMode>[];

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ModeSwitcher(
              currentMode: FilterMode.protanopia,
              onModeChanged: (mode) => selectedModes.add(mode),
            ),
          ),
        ),
      );

      // Tap each mode
      await tester.tap(find.text('Tritanopia'));
      await tester.pumpAndSettle();

      await tester.tap(find.text('Achromatopsia'));
      await tester.pumpAndSettle();

      expect(selectedModes, [FilterMode.tritanopia, FilterMode.achromatopsia]);
    });

    testWidgets('renders within a SingleChildScrollView', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ModeSwitcher(
              currentMode: FilterMode.protanopia,
              onModeChanged: (_) {},
            ),
          ),
        ),
      );

      // ModeSwitcher should use SingleChildScrollView for horizontal scrolling
      expect(find.byType(SingleChildScrollView), findsOneWidget);
    });
  });
}
