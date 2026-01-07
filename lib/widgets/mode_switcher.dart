import 'package:flutter/material.dart';

import '../models/filter_mode.dart';
import '../theme/app_colors.dart';
import '../theme/app_spacing.dart';

/// A horizontal row of buttons for switching between colorblind filter modes.
class ModeSwitcher extends StatelessWidget {
  const ModeSwitcher({
    super.key,
    required this.currentMode,
    required this.onModeChanged,
  });

  /// The currently active filter mode.
  final FilterMode currentMode;

  /// Callback when a new mode is selected.
  final ValueChanged<FilterMode> onModeChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.sm,
        vertical: AppSpacing.md,
      ),
      decoration: BoxDecoration(
        color: Colors.black.withAlpha(179), // 70% opacity
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(AppSpacing.md),
        ),
      ),
      child: SafeArea(
        top: false,
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: FilterMode.values.map((mode) {
              final isActive = mode == currentMode;
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xs),
                child: _ModeButton(
                  mode: mode,
                  isActive: isActive,
                  onTap: () => onModeChanged(mode),
                ),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}

class _ModeButton extends StatelessWidget {
  const _ModeButton({
    required this.mode,
    required this.isActive,
    required this.onTap,
  });

  final FilterMode mode;
  final bool isActive;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 150),
      curve: Curves.easeInOut,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(AppSpacing.sm),
          child: Container(
            constraints: const BoxConstraints(
              minWidth: AppSpacing.touchTarget,
              minHeight: AppSpacing.touchTarget,
            ),
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.md,
              vertical: AppSpacing.sm,
            ),
            decoration: BoxDecoration(
              color: isActive ? mode.buttonColor : Colors.transparent,
              borderRadius: BorderRadius.circular(AppSpacing.sm),
              border: Border.all(
                color: isActive ? mode.buttonColor : AppColors.badge,
                width: isActive ? 2 : 1,
              ),
              boxShadow: isActive
                  ? [
                      BoxShadow(
                        color: mode.buttonColor.withAlpha(102), // 40% opacity
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ]
                  : null,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  mode.localizedDisplayName(context),
                  style: TextStyle(
                    color: isActive ? Colors.white : AppColors.badge,
                    fontSize: 12,
                    fontWeight: isActive ? FontWeight.w600 : FontWeight.w400,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  mode.localizedShortName(context),
                  style: TextStyle(
                    color: isActive
                        ? Colors.white.withAlpha(204) // 80% opacity
                        : AppColors.badge.withAlpha(179), // 70% opacity
                    fontSize: 10,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
