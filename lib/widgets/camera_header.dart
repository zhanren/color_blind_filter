import 'package:flutter/material.dart';

import '../models/filter_mode.dart';
import '../models/view_mode.dart';
import '../theme/app_colors.dart';
import '../theme/app_spacing.dart';
import 'animal_icon_button.dart';
import 'camera_flip_button.dart';
import 'settings_button.dart';
import 'view_toggle_button.dart';

/// A semi-transparent header bar for the camera screen.
///
/// Contains the view toggle button, camera flip button, mode label, animal info button, and settings button.
/// Properly respects safe areas to avoid overlapping with system UI.
class CameraHeader extends StatelessWidget {
  const CameraHeader({
    super.key,
    required this.filterMode,
    required this.viewMode,
    required this.onViewToggle,
    required this.onAnimalTap,
    required this.onSettingsTap,
    this.onCameraFlip,
    this.showCameraFlip = false,
    this.isSwitchingCamera = false,
    this.showModeLabel = true,
  });

  /// The current colorblind filter mode.
  final FilterMode filterMode;

  /// The current view mode (full screen or split).
  final ViewMode viewMode;

  /// Callback when the view toggle button is tapped.
  final VoidCallback onViewToggle;

  /// Callback when the animal info button is tapped.
  final VoidCallback onAnimalTap;

  /// Callback when the settings button is tapped.
  final VoidCallback onSettingsTap;

  /// Callback when the camera flip button is tapped.
  final VoidCallback? onCameraFlip;

  /// Whether to show the camera flip button.
  final bool showCameraFlip;

  /// Whether a camera switch is in progress.
  final bool isSwitchingCamera;

  /// Whether to show the mode label (hidden in split view).
  final bool showModeLabel;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.black.withAlpha(200), // Solid semi-transparent background
        border: Border(
          bottom: BorderSide(
            color: Colors.white.withAlpha(30),
            width: 1,
          ),
        ),
      ),
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.md,
            vertical: AppSpacing.sm,
          ),
          child: Row(
            children: [
              // View toggle button (left)
              ViewToggleButton(
                currentMode: viewMode,
                onToggle: onViewToggle,
              ),

              // Camera flip button (next to view toggle)
              if (showCameraFlip && onCameraFlip != null) ...[
                const SizedBox(width: AppSpacing.sm),
                CameraFlipButton(
                  onPressed: onCameraFlip!,
                  isLoading: isSwitchingCamera,
                ),
              ],

              // Mode label (center) - only in full screen mode
              Expanded(
                child: showModeLabel
                    ? _buildModeLabel(context)
                    : const SizedBox.shrink(),
              ),

              // Animal info button
              AnimalIconButton(
                animalInfo: filterMode.animalInfo,
                onTap: onAnimalTap,
              ),

              const SizedBox(width: AppSpacing.sm),

              // Settings button (right)
              SettingsButton(
                onPressed: onSettingsTap,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildModeLabel(BuildContext context) {
    return Center(
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.xs,
        ),
        decoration: BoxDecoration(
          color: AppColors.cameraOverlay,
          borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              filterMode.animalInfo.emoji,
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(width: AppSpacing.xs),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  filterMode.localizedDisplayName(context),
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                ),
                Text(
                  filterMode.localizedShortName(context),
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Colors.white70,
                        fontSize: 10,
                      ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
