import 'package:color_blind_filter/utils/color_matrices.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('ColorMatrices', () {
    test('all matrices have exactly 20 elements', () {
      expect(ColorMatrices.protanopia.length, 20);
      expect(ColorMatrices.deuteranopia.length, 20);
      expect(ColorMatrices.tritanopia.length, 20);
      expect(ColorMatrices.achromatopsia.length, 20);
      expect(ColorMatrices.identity.length, 20);
    });

    test('identity matrix has correct diagonal values', () {
      const identity = ColorMatrices.identity;

      // R row: [1, 0, 0, 0, 0]
      expect(identity[0], 1); // R → R
      expect(identity[1], 0);
      expect(identity[2], 0);
      expect(identity[3], 0);
      expect(identity[4], 0);

      // G row: [0, 1, 0, 0, 0]
      expect(identity[5], 0);
      expect(identity[6], 1); // G → G
      expect(identity[7], 0);
      expect(identity[8], 0);
      expect(identity[9], 0);

      // B row: [0, 0, 1, 0, 0]
      expect(identity[10], 0);
      expect(identity[11], 0);
      expect(identity[12], 1); // B → B
      expect(identity[13], 0);
      expect(identity[14], 0);

      // A row: [0, 0, 0, 1, 0]
      expect(identity[15], 0);
      expect(identity[16], 0);
      expect(identity[17], 0);
      expect(identity[18], 1); // A → A
      expect(identity[19], 0);
    });

    test('alpha channel is preserved in all color matrices', () {
      final matrices = [
        ColorMatrices.protanopia,
        ColorMatrices.deuteranopia,
        ColorMatrices.tritanopia,
        ColorMatrices.achromatopsia,
      ];

      for (final matrix in matrices) {
        // Alpha row should be [0, 0, 0, 1, 0] to preserve original alpha
        expect(matrix[15], 0, reason: 'A from R should be 0');
        expect(matrix[16], 0, reason: 'A from G should be 0');
        expect(matrix[17], 0, reason: 'A from B should be 0');
        expect(matrix[18], 1, reason: 'A from A should be 1');
        expect(matrix[19], 0, reason: 'A offset should be 0');
      }
    });

    test('achromatopsia matrix produces grayscale (same R,G,B coefficients)',
        () {
      const matrix = ColorMatrices.achromatopsia;

      // All three output rows should have identical RGB coefficients
      // R row coefficients
      final rFromR = matrix[0];
      final rFromG = matrix[1];
      final rFromB = matrix[2];

      // G row coefficients
      final gFromR = matrix[5];
      final gFromG = matrix[6];
      final gFromB = matrix[7];

      // B row coefficients
      final bFromR = matrix[10];
      final bFromG = matrix[11];
      final bFromB = matrix[12];

      // All rows should have same coefficients for grayscale
      expect(rFromR, gFromR);
      expect(rFromR, bFromR);
      expect(rFromG, gFromG);
      expect(rFromG, bFromG);
      expect(rFromB, gFromB);
      expect(rFromB, bFromB);
    });

    test('protanopia matrix values are within valid range [0, 1]', () {
      for (final value in ColorMatrices.protanopia) {
        expect(value, greaterThanOrEqualTo(0));
        expect(value, lessThanOrEqualTo(1));
      }
    });
  });
}
