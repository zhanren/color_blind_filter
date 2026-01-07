import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/app_spacing.dart';

/// A button that opens the settings screen.
class SettingsButton extends StatelessWidget {
  const SettingsButton({
    super.key,
    required this.onPressed,
  });

  /// Callback when the button is pressed.
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onPressed,
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
          child: const Center(
            child: Icon(
              Icons.settings,
              color: Colors.white,
              size: 24,
            ),
          ),
        ),
      ),
    );
  }
}
