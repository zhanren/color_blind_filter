import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

import '../l10n/app_localizations.dart';
import '../models/filter_mode.dart';
import '../theme/app_colors.dart';
import '../theme/app_spacing.dart';
import '../utils/color_matrices.dart';

/// Widget that displays side-by-side camera previews:
/// - Both orientations: Left (Normal) / Right (Filtered)
class SplitCameraPreview extends StatelessWidget {
  const SplitCameraPreview({
    super.key,
    required this.controller,
    required this.filterMode,
    this.isFrontCamera = false,
  });

  /// The camera controller providing the preview stream.
  final CameraController controller;

  /// The current filter mode for the filtered side.
  final FilterMode filterMode;

  /// Whether the front camera is active (for mirroring).
  final bool isFrontCamera;

  @override
  Widget build(BuildContext context) {
    if (!controller.value.isInitialized) {
      return const _LoadingPreview();
    }

    final l10n = AppLocalizations.of(context);
    
    final normalPane = _PreviewPane(
      controller: controller,
      colorMatrix: ColorMatrices.identity,
      label: l10n.normal,
      isFrontCamera: isFrontCamera,
    );

    final filteredPane = _PreviewPane(
      controller: controller,
      colorMatrix: filterMode.colorMatrix,
      label: filterMode.localizedDisplayName(context),
      isFrontCamera: isFrontCamera,
    );

    final dividerColor = Colors.white.withAlpha(179);
    final isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;

    // Portrait: top/bottom layout, Landscape: left/right layout
    if (isLandscape) {
      return Row(
        children: [
          Expanded(child: normalPane),
          Container(width: 2, color: dividerColor),
          Expanded(child: filteredPane),
        ],
      );
    } else {
      return Column(
        children: [
          Expanded(child: normalPane),
          Container(height: 2, color: dividerColor),
          Expanded(child: filteredPane),
        ],
      );
    }
  }
}

/// A single preview pane with label.
class _PreviewPane extends StatelessWidget {
  const _PreviewPane({
    required this.controller,
    required this.colorMatrix,
    required this.label,
    this.isFrontCamera = false,
  });

  final CameraController controller;
  final List<double> colorMatrix;
  final String label;
  final bool isFrontCamera;

  @override
  Widget build(BuildContext context) {
    final isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    
    // Camera sensor dimensions
    final sensorWidth = controller.value.previewSize?.width ?? 1;
    final sensorHeight = controller.value.previewSize?.height ?? 1;
    
    // In portrait mode: swap dimensions (camera is landscape, display is portrait)
    // In landscape mode: keep natural dimensions
    final previewWidth = isLandscape ? sensorWidth : sensorHeight;
    final previewHeight = isLandscape ? sensorHeight : sensorWidth;
    
    Widget cameraPreview = ColorFiltered(
      colorFilter: ColorFilter.matrix(colorMatrix),
      child: SizedBox(
        width: previewWidth,
        height: previewHeight,
        child: CameraPreview(controller),
      ),
    );

    // Mirror front camera for natural selfie view
    if (isFrontCamera) {
      cameraPreview = Transform.scale(
        scaleX: -1,
        child: cameraPreview,
      );
    }

    // Use cover to fill the pane naturally (crops to fit, like normal camera)
    final previewWidget = ClipRect(
      child: FittedBox(
        fit: BoxFit.cover,
        child: cameraPreview,
      ),
    );

    return Stack(
      fit: StackFit.expand,
      children: [
        // Camera preview with filter
        previewWidget,

        // Label at top
        Positioned(
          top: AppSpacing.sm,
          left: 0,
          right: 0,
          child: Center(
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.sm,
                vertical: AppSpacing.xs,
              ),
              decoration: BoxDecoration(
                color: AppColors.cameraOverlay,
                borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
              ),
              child: Text(
                label,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ),
      ],
    );
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
