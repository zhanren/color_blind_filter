import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

/// Widget that displays the camera preview with an optional color filter.
class FilteredCameraPreview extends StatelessWidget {
  const FilteredCameraPreview({
    super.key,
    required this.controller,
    required this.colorMatrix,
    this.isFrontCamera = false,
  });

  /// The camera controller providing the preview stream.
  final CameraController controller;

  /// The 5x4 color matrix to apply as a filter.
  final List<double> colorMatrix;

  /// Whether the front camera is active (for mirroring).
  final bool isFrontCamera;

  @override
  Widget build(BuildContext context) {
    if (!controller.value.isInitialized) {
      return const _LoadingPreview();
    }

    final isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    
    // Camera sensor dimensions
    final sensorWidth = controller.value.previewSize?.width ?? 1;
    final sensorHeight = controller.value.previewSize?.height ?? 1;
    
    // In portrait mode: swap dimensions (camera is landscape, display is portrait)
    // In landscape mode: keep natural dimensions
    final previewWidth = isLandscape ? sensorWidth : sensorHeight;
    final previewHeight = isLandscape ? sensorHeight : sensorWidth;

    Widget preview = ColorFiltered(
      colorFilter: ColorFilter.matrix(colorMatrix),
      child: SizedBox.expand(
        child: FittedBox(
          fit: BoxFit.cover,
          child: SizedBox(
            width: previewWidth,
            height: previewHeight,
            child: CameraPreview(controller),
          ),
        ),
      ),
    );

    // Mirror front camera for natural selfie view
    if (isFrontCamera) {
      preview = Transform.scale(
        scaleX: -1,
        child: preview,
      );
    }

    return preview;
  }
}

/// Loading state shown while camera initializes.
class _LoadingPreview extends StatelessWidget {
  const _LoadingPreview();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      child: const Center(
        child: CircularProgressIndicator(
          color: AppColors.primary,
        ),
      ),
    );
  }
}
