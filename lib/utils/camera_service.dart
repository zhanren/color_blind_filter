import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';

/// Service for camera initialization and lifecycle management.
class CameraService {
  CameraController? _controller;
  List<CameraDescription>? _cameras;
  CameraLensDirection _currentLensDirection = CameraLensDirection.back;
  
  // Zoom state
  double _currentZoom = 1.0;
  double _minZoom = 1.0;
  double _maxZoom = 1.0;

  /// Whether the camera is initialized and ready for use.
  bool get isInitialized => _controller?.value.isInitialized ?? false;

  /// The active camera controller.
  CameraController? get controller => _controller;

  /// The current camera lens direction (front or back).
  CameraLensDirection get lensDirection => _currentLensDirection;

  /// Whether the device has multiple cameras (front and back).
  bool get hasMultipleCameras {
    if (_cameras == null) return false;
    final hasBack = _cameras!.any((c) => c.lensDirection == CameraLensDirection.back);
    final hasFront = _cameras!.any((c) => c.lensDirection == CameraLensDirection.front);
    return hasBack && hasFront;
  }

  /// Current zoom level (1.0 = no zoom).
  double get currentZoom => _currentZoom;

  /// Minimum zoom level supported by device.
  double get minZoom => _minZoom;

  /// Maximum zoom level supported by device.
  double get maxZoom => _maxZoom;

  /// Set the camera zoom level.
  ///
  /// The [zoom] value is clamped between [minZoom] and [maxZoom].
  Future<void> setZoom(double zoom) async {
    if (_controller == null || !_controller!.value.isInitialized) return;

    try {
      final clampedZoom = zoom.clamp(_minZoom, _maxZoom);
      await _controller!.setZoomLevel(clampedZoom);
      _currentZoom = clampedZoom;
    } on CameraException catch (e) {
      debugPrint('Camera zoom error: ${e.description}');
    }
  }

  /// Reset zoom to default level (1.0).
  Future<void> resetZoom() async {
    await setZoom(1.0);
  }

  /// Initialize zoom limits from the camera controller.
  Future<void> _initializeZoom() async {
    if (_controller == null || !_controller!.value.isInitialized) return;

    try {
      _minZoom = await _controller!.getMinZoomLevel();
      _maxZoom = await _controller!.getMaxZoomLevel();
      _currentZoom = 1.0;
    } on CameraException catch (e) {
      debugPrint('Camera zoom init error: ${e.description}');
      _minZoom = 1.0;
      _maxZoom = 1.0;
      _currentZoom = 1.0;
    }
  }

  /// Initialize the back-facing camera.
  ///
  /// Uses high resolution for sharp, clear preview.
  /// Throws [CameraException] if initialization fails.
  Future<void> initialize() async {
    try {
      _cameras ??= await availableCameras();

      if (_cameras == null || _cameras!.isEmpty) {
        throw CameraException(
          'noCameras',
          'No cameras available on this device',
        );
      }

      // Prefer back camera, fall back to first available
      final backCamera = _cameras!.firstWhere(
        (c) => c.lensDirection == CameraLensDirection.back,
        orElse: () => _cameras!.first,
      );

      _currentLensDirection = backCamera.lensDirection;

      _controller = CameraController(
        backCamera,
        ResolutionPreset.high, // High resolution for sharp preview
        enableAudio: false, // Not needed for this app
        imageFormatGroup: ImageFormatGroup.jpeg,
      );

      await _controller!.initialize();
      await _initializeZoom();
    } on CameraException catch (e) {
      debugPrint('Camera initialization error: ${e.code} - ${e.description}');
      rethrow;
    }
  }

  /// Switch between front and back cameras.
  ///
  /// Returns true if switch was successful.
  Future<bool> switchCamera() async {
    if (_cameras == null || _cameras!.length < 2) {
      return false;
    }

    try {
      // Determine new direction
      final newDirection = _currentLensDirection == CameraLensDirection.back
          ? CameraLensDirection.front
          : CameraLensDirection.back;

      // Find camera with new direction
      final newCamera = _cameras!.firstWhere(
        (c) => c.lensDirection == newDirection,
        orElse: () => _cameras!.first,
      );

      // Dispose old controller
      await _controller?.dispose();

      // Create new controller
      _controller = CameraController(
        newCamera,
        ResolutionPreset.high,
        enableAudio: false,
        imageFormatGroup: ImageFormatGroup.jpeg,
      );

      await _controller!.initialize();
      _currentLensDirection = newDirection;
      
      // Re-initialize zoom limits for new camera and reset to 1x
      await _initializeZoom();

      return true;
    } on CameraException catch (e) {
      debugPrint('Camera switch error: ${e.description}');
      return false;
    }
  }

  /// Pause the camera preview.
  ///
  /// Call when app goes to background.
  Future<void> pause() async {
    if (_controller != null && _controller!.value.isInitialized) {
      try {
        await _controller!.pausePreview();
      } on CameraException catch (e) {
        debugPrint('Camera pause error: ${e.description}');
      }
    }
  }

  /// Resume the camera preview.
  ///
  /// Call when app returns to foreground.
  Future<void> resume() async {
    if (_controller != null && _controller!.value.isInitialized) {
      try {
        await _controller!.resumePreview();
      } on CameraException catch (e) {
        debugPrint('Camera resume error: ${e.description}');
      }
    }
  }

  /// Take a picture and return the file.
  ///
  /// Returns the [XFile] containing the captured image.
  /// Throws [CameraException] if capture fails.
  Future<XFile?> takePicture() async {
    if (_controller == null || !_controller!.value.isInitialized) {
      return null;
    }

    try {
      final XFile file = await _controller!.takePicture();
      return file;
    } on CameraException catch (e) {
      debugPrint('Camera capture error: ${e.description}');
      return null;
    }
  }

  /// Dispose of camera resources.
  ///
  /// Must be called when camera is no longer needed.
  Future<void> dispose() async {
    await _controller?.dispose();
    _controller = null;
  }
}
