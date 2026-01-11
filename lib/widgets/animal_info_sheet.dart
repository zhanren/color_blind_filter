import 'package:flutter/material.dart';

import '../models/animal_info.dart';
import '../theme/app_spacing.dart';

/// A bottom sheet displaying expanded animal information.
///
/// Shows the animal's name, emoji, and a kid-friendly fact about their vision.
class AnimalInfoSheet extends StatelessWidget {
  const AnimalInfoSheet({
    super.key,
    required this.animalInfo,
  });

  /// The animal info to display.
  final AnimalInfo animalInfo;

  /// Shows the animal info sheet as a modal bottom sheet.
  static Future<void> show(BuildContext context, AnimalInfo animalInfo) {
    return showModalBottomSheet<void>(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (_) => AnimalInfoSheet(animalInfo: animalInfo),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(AppSpacing.radiusLg),
        ),
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Drag handle
              Container(
                width: 40,
                height: 4,
                margin: const EdgeInsets.only(bottom: AppSpacing.lg),
                decoration: BoxDecoration(
                  color: theme.colorScheme.onSurface.withAlpha(51),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),

              // Animal image
              ClipOval(
                child: Image.asset(
                  animalInfo.imagePath,
                  width: 100,
                  height: 100,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    // Fallback to emoji if image not found
                    return Text(
                      animalInfo.emoji,
                      style: const TextStyle(fontSize: 64),
                    );
                  },
                ),
              ),

              const SizedBox(height: AppSpacing.md),

              // Animal name
              Text(
                animalInfo.name,
                style: theme.textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: AppSpacing.lg),

              // "Did you know?" header
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.md,
                  vertical: AppSpacing.xs,
                ),
                decoration: BoxDecoration(
                  color: theme.colorScheme.primary.withAlpha(26),
                  borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
                ),
                child: Text(
                  'Did you know?',
                  style: theme.textTheme.labelLarge?.copyWith(
                    color: theme.colorScheme.primary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),

              const SizedBox(height: AppSpacing.md),

              // Fact text
              Text(
                animalInfo.fact,
                style: theme.textTheme.bodyLarge?.copyWith(
                  height: 1.5,
                ),
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: AppSpacing.lg),
            ],
          ),
        ),
      ),
    );
  }
}
