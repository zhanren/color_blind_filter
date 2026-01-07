import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/app_spacing.dart';

/// A button that flips between front and back cameras.
class CameraFlipButton extends StatelessWidget {
  const CameraFlipButton({
    super.key,
    required this.onPressed,
    this.isLoading = false,
  });

  /// Callback when the button is pressed.
  final VoidCallback onPressed;

  /// Whether a camera switch is in progress.
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: isLoading ? null : onPressed,
        borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
        child: Container(
          width: AppSpacing.touchTarget,
          height: AppSpacing.touchTarget,
          decoration: BoxDecoration(
            color: AppColors.cameraOverlay,
            shape: BoxShape.circle,
            border: Border.all(
              color: AppColors.badge.withAlpha(128),
              width: 1.5,
            ),
          ),
          child: Center(
            child: isLoading
                ? const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: Colors.white,
                    ),
                  )
                : const Icon(
                    Icons.flip_camera_ios,
                    color: Colors.white,
                    size: 24,
                  ),
          ),
        ),
      ),
    );
  }
}
