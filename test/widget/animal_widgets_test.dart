import 'package:color_blind_filter/models/animal_info.dart';
import 'package:color_blind_filter/widgets/animal_icon_button.dart';
import 'package:color_blind_filter/widgets/animal_info_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const testAnimal = AnimalInfo(
    name: 'Dog',
    emoji: '🐕',
    imagePath: 'assets/icons/dog.png',
    fact: 'Dogs can see blue and yellow!',
  );

  group('AnimalIconButton', () {
    testWidgets('renders animal image or emoji fallback', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AnimalIconButton(
              animalInfo: testAnimal,
              onTap: () {},
            ),
          ),
        ),
      );

      // Looks for Image.asset widget (or emoji fallback in test environment)
      expect(find.byType(Image), findsOneWidget);
    });

    testWidgets('triggers onTap callback when pressed', (tester) async {
      var tapped = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AnimalIconButton(
              animalInfo: testAnimal,
              onTap: () => tapped = true,
            ),
          ),
        ),
      );

      await tester.tap(find.byType(AnimalIconButton));
      await tester.pumpAndSettle();

      expect(tapped, isTrue);
    });

    testWidgets('has circular shape', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AnimalIconButton(
              animalInfo: testAnimal,
              onTap: () {},
            ),
          ),
        ),
      );

      final container = tester.widget<Container>(
        find.descendant(
          of: find.byType(AnimalIconButton),
          matching: find.byType(Container).first,
        ),
      );

      final decoration = container.decoration as BoxDecoration?;
      expect(decoration?.shape, BoxShape.circle);
    });
  });

  group('AnimalInfoSheet', () {
    testWidgets('displays animal image or emoji fallback', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: AnimalInfoSheet(animalInfo: testAnimal),
          ),
        ),
      );

      // Looks for Image.asset widget (or emoji fallback in test environment)
      expect(find.byType(Image), findsOneWidget);
    });

    testWidgets('displays animal name', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: AnimalInfoSheet(animalInfo: testAnimal),
          ),
        ),
      );

      expect(find.text('Dog'), findsOneWidget);
    });

    testWidgets('displays "Did you know?" header', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: AnimalInfoSheet(animalInfo: testAnimal),
          ),
        ),
      );

      expect(find.text('Did you know?'), findsOneWidget);
    });

    testWidgets('displays fact text', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: AnimalInfoSheet(animalInfo: testAnimal),
          ),
        ),
      );

      expect(find.text('Dogs can see blue and yellow!'), findsOneWidget);
    });

    testWidgets('show() opens modal bottom sheet', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Builder(
              builder: (context) => ElevatedButton(
                onPressed: () => AnimalInfoSheet.show(context, testAnimal),
                child: const Text('Open'),
              ),
            ),
          ),
        ),
      );

      // Sheet not visible initially
      expect(find.text('Dog'), findsNothing);

      // Tap button to open sheet
      await tester.tap(find.text('Open'));
      await tester.pumpAndSettle();

      // Sheet is now visible
      expect(find.text('Dog'), findsOneWidget);
      expect(find.text('Did you know?'), findsOneWidget);
    });
  });
}
