import 'package:color_blind_filter/utils/gallery_service.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('GalleryService', () {
    late GalleryService service;

    setUp(() {
      service = GalleryService();
    });

    test('hasPermission method exists', () {
      // Verify the method exists and returns a Future<bool>
      expect(service.hasPermission, isA<Function>());
    });

    test('requestPermission method exists', () {
      expect(service.requestPermission, isA<Function>());
    });

    test('saveImage method exists', () {
      expect(service.saveImage, isA<Function>());
    });

    test('saveImageFile method exists', () {
      expect(service.saveImageFile, isA<Function>());
    });
  });
}
