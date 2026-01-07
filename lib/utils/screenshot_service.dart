import 'dart:io';
import 'dart:ui' as ui;

import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:path_provider/path_provider.dart';

/// Service for capturing screenshots of widgets.
class ScreenshotService {
  /// Capture a widget wrapped in RepaintBoundary and save to a temp file.
  ///
  /// Returns the path to the captured image file, or null if capture fails.
  static Future<String?> capture(GlobalKey boundaryKey) async {
    try {
      // Get the RenderRepaintBoundary
      final boundary = boundaryKey.currentContext?.findRenderObject()
          as RenderRepaintBoundary?;

      if (boundary == null) {
        return null;
      }

      // Capture as image
      final ui.Image image = await boundary.toImage(pixelRatio: 2.0);
      final byteData = await image.toByteData(format: ui.ImageByteFormat.png);

      if (byteData == null) {
        return null;
      }

      // Save to temp file
      final tempDir = await getTemporaryDirectory();
      final timestamp = DateTime.now().millisecondsSinceEpoch;
      final filePath = '${tempDir.path}/capture_$timestamp.png';

      final file = File(filePath);
      await file.writeAsBytes(byteData.buffer.asUint8List());

      return filePath;
    } catch (e) {
      return null;
    }
  }
}
