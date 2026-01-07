import 'package:color_blind_filter/models/filter_mode.dart';
import 'package:color_blind_filter/utils/color_matrices.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('FilterMode enum', () {
    test('has exactly 4 values', () {
      expect(FilterMode.values.length, 4);
    });

    test('contains all expected modes', () {
      expect(FilterMode.values, contains(FilterMode.protanopia));
      expect(FilterMode.values, contains(FilterMode.deuteranopia));
      expect(FilterMode.values, contains(FilterMode.tritanopia));
      expect(FilterMode.values, contains(FilterMode.achromatopsia));
    });
  });

  group('FilterMode displayName', () {
    test('returns correct display names', () {
      expect(FilterMode.protanopia.displayName, 'Protanopia');
      expect(FilterMode.deuteranopia.displayName, 'Deuteranopia');
      expect(FilterMode.tritanopia.displayName, 'Tritanopia');
      expect(FilterMode.achromatopsia.displayName, 'Achromatopsia');
    });
  });

  group('FilterMode shortName', () {
    test('returns correct short names', () {
      expect(FilterMode.protanopia.shortName, 'Red-blind');
      expect(FilterMode.deuteranopia.shortName, 'Green-blind');
      expect(FilterMode.tritanopia.shortName, 'Blue-blind');
      expect(FilterMode.achromatopsia.shortName, 'Monochrome');
    });
  });

  group('FilterMode colorMatrix', () {
    test('protanopia returns correct matrix', () {
      expect(FilterMode.protanopia.colorMatrix, ColorMatrices.protanopia);
    });

    test('deuteranopia returns correct matrix', () {
      expect(FilterMode.deuteranopia.colorMatrix, ColorMatrices.deuteranopia);
    });

    test('tritanopia returns correct matrix', () {
      expect(FilterMode.tritanopia.colorMatrix, ColorMatrices.tritanopia);
    });

    test('achromatopsia returns correct matrix', () {
      expect(FilterMode.achromatopsia.colorMatrix, ColorMatrices.achromatopsia);
    });

    test('each mode returns a 20-element matrix', () {
      for (final mode in FilterMode.values) {
        expect(mode.colorMatrix.length, 20);
      }
    });
  });

  group('FilterMode buttonColor', () {
    test('each mode has a unique button color', () {
      final colors = FilterMode.values.map((m) => m.buttonColor).toSet();
      expect(colors.length, 4); // All unique
    });

    test('button colors are not null', () {
      for (final mode in FilterMode.values) {
        expect(mode.buttonColor, isNotNull);
      }
    });
  });
}
