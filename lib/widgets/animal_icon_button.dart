import 'package:flutter/material.dart';

import '../models/animal_info.dart';
import '../theme/app_colors.dart';
import '../theme/app_spacing.dart';

/// A circular button displaying an animal emoji.
///
/// Positioned in the corner of the camera view to show which animal
/// has similar vision to the current colorblind mode.
class AnimalIconButton extends StatelessWidget {
  const AnimalIconButton({
    super.key,
    required this.animalInfo,
    required this.onTap,
  });

  /// The animal info to display.
  final AnimalInfo animalInfo;

  /// Callback when the button is tapped.
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
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
            child: Text(
              animalInfo.emoji,
              style: const TextStyle(fontSize: 24),
            ),
          ),
        ),
      ),
    );
  }
}
