import 'package:color_blind_filter/models/animal_info.dart';
import 'package:color_blind_filter/models/filter_mode.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('AnimalInfo', () {
    test('has required properties', () {
      const info = AnimalInfo(
        name: 'Test',
        emoji: '🐾',
        imagePath: 'assets/icons/test.png',
        fact: 'Test fact',
      );

      expect(info.name, 'Test');
      expect(info.emoji, '🐾');
      expect(info.imagePath, 'assets/icons/test.png');
      expect(info.fact, 'Test fact');
    });
  });

  group('AnimalData', () {
    test('dog has correct data', () {
      expect(AnimalData.dog.name, 'Dog');
      expect(AnimalData.dog.emoji, '🐕');
      expect(AnimalData.dog.imagePath, 'assets/icons/dog.png');
      expect(AnimalData.dog.fact, isNotEmpty);
    });

    test('mouse has correct data', () {
      expect(AnimalData.mouse.name, 'Mouse');
      expect(AnimalData.mouse.emoji, '🐭');
      expect(AnimalData.mouse.imagePath, 'assets/icons/mouse.png');
      expect(AnimalData.mouse.fact, isNotEmpty);
    });

    test('whale has correct data', () {
      expect(AnimalData.whale.name, 'Whale');
      expect(AnimalData.whale.emoji, '🐋');
      expect(AnimalData.whale.imagePath, 'assets/icons/whale.png');
      expect(AnimalData.whale.fact, isNotEmpty);
    });

    test('owl has correct data', () {
      expect(AnimalData.owl.name, 'Owl');
      expect(AnimalData.owl.emoji, '🦉');
      expect(AnimalData.owl.imagePath, 'assets/icons/owl.png');
      expect(AnimalData.owl.fact, isNotEmpty);
    });
  });

  group('FilterMode.animalInfo', () {
    test('protanopia returns dog', () {
      expect(FilterMode.protanopia.animalInfo, AnimalData.dog);
    });

    test('deuteranopia returns mouse', () {
      expect(FilterMode.deuteranopia.animalInfo, AnimalData.mouse);
    });

    test('tritanopia returns whale', () {
      expect(FilterMode.tritanopia.animalInfo, AnimalData.whale);
    });

    test('achromatopsia returns owl', () {
      expect(FilterMode.achromatopsia.animalInfo, AnimalData.owl);
    });

    test('each mode has unique animal', () {
      final animals = FilterMode.values.map((m) => m.animalInfo.name).toSet();
      expect(animals.length, 4);
    });
  });
}
