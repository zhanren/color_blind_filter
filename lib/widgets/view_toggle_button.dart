import 'package:flutter/material.dart';

import '../models/view_mode.dart';
import '../theme/app_colors.dart';
import '../theme/app_spacing.dart';

/// A button that toggles between full screen and split view modes.
class ViewToggleButton extends StatelessWidget {
  const ViewToggleButton({
    super.key,
    required this.currentMode,
    required this.onToggle,
  });

  /// The current view mode.
  final ViewMode currentMode;

  /// Callback when the button is tapped.
  final VoidCallback onToggle;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onToggle,
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
            child: Icon(
              currentMode.icon,
              color: Colors.white,
              size: 24,
            ),
          ),
        ),
      ),
    );
  }
}
