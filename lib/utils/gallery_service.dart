import 'dart:io';
import 'dart:typed_data';

import 'package:gal/gal.dart';
import 'package:path_provider/path_provider.dart';

/// Service for saving images to the device photo gallery.
class GalleryService {
  /// Check if the app has permission to save to gallery.
  Future<bool> hasPermission() async {
    return Gal.hasAccess();
  }

  /// Request permission to save to gallery.
  /// Returns true if permission was granted.
  Future<bool> requestPermission() async {
    return Gal.requestAccess();
  }

  /// Save image bytes to the device gallery.
  /// Returns true if successful.
  Future<bool> saveImage(Uint8List imageBytes, String fileName) async {
    try {
      // Get temp directory
      final tempDir = await getTemporaryDirectory();
      final tempPath = '${tempDir.path}/$fileName';

      // Write bytes to temp file
      final file = File(tempPath);
      await file.writeAsBytes(imageBytes);

      // Save to gallery
      await Gal.putImage(tempPath, album: 'Color Blind Filter');

      // Clean up temp file
      await file.delete();

      return true;
    } catch (e) {
      return false;
    }
  }

  /// Save a file directly to the gallery.
  Future<bool> saveImageFile(String filePath) async {
    try {
      await Gal.putImage(filePath, album: 'Color Blind Filter');
      return true;
    } catch (e) {
      return false;
    }
  }
}
