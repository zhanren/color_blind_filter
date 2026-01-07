import 'dart:io';

import 'package:flutter/material.dart';

import '../l10n/app_localizations.dart';
import '../models/filter_mode.dart';
import '../theme/app_colors.dart';
import '../theme/app_spacing.dart';
import '../utils/gallery_service.dart';

/// Arguments passed to the review screen.
class ReviewScreenArgs {
  const ReviewScreenArgs({
    required this.imagePath,
    required this.filterMode,
  });

  /// Path to the captured image file.
  final String imagePath;

  /// The filter mode that was active when the photo was taken.
  final FilterMode filterMode;
}

/// Screen for reviewing a captured photo before saving.
class ReviewScreen extends StatefulWidget {
  const ReviewScreen({super.key});

  @override
  State<ReviewScreen> createState() => _ReviewScreenState();
}

class _ReviewScreenState extends State<ReviewScreen> {
  final GalleryService _galleryService = GalleryService();
  bool _isSaving = false;

  Future<void> _savePhoto(String imagePath) async {
    setState(() => _isSaving = true);
    final l10n = AppLocalizations.of(context);

    try {
      // Check permission
      final hasPermission = await _galleryService.hasPermission();
      if (!hasPermission) {
        final granted = await _galleryService.requestPermission();
        if (!granted) {
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(l10n.saveFailed),
                backgroundColor: AppColors.error,
              ),
            );
            setState(() => _isSaving = false);
          }
          return;
        }
      }

      // Save to gallery
      final success = await _galleryService.saveImageFile(imagePath);

      if (mounted) {
        if (success) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('${l10n.saved} 📸'),
              backgroundColor: AppColors.success,
            ),
          );
          Navigator.of(context).pop(true); // Return success
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(l10n.saveFailed),
              backgroundColor: AppColors.error,
            ),
          );
        }
      }
    } finally {
      if (mounted) {
        setState(() => _isSaving = false);
      }
    }
  }

  void _retake() {
    Navigator.of(context).pop(false); // Return without saving
  }

  @override
  Widget build(BuildContext context) {
    final route = ModalRoute.of(context);
    if (route == null || route.settings.arguments == null) {
      // Safety: if no arguments, return to previous screen
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) Navigator.of(context).pop();
      });
      return const Scaffold(
        backgroundColor: Colors.black,
        body: Center(child: CircularProgressIndicator()),
      );
    }
    final args = route.settings.arguments as ReviewScreenArgs;

    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Image preview
          Image.file(
            File(args.imagePath),
            fit: BoxFit.contain,
          ),

          // Filter label at top
          Positioned(
            top: MediaQuery.of(context).padding.top + AppSpacing.md,
            left: 0,
            right: 0,
            child: Center(
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.md,
                  vertical: AppSpacing.sm,
                ),
                decoration: BoxDecoration(
                  color: AppColors.cameraOverlay,
                  borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      args.filterMode.animalInfo.emoji,
                      style: const TextStyle(fontSize: 20),
                    ),
                    const SizedBox(width: AppSpacing.sm),
                    Text(
                      args.filterMode.localizedDisplayName(context),
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Action buttons at bottom
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              padding: EdgeInsets.fromLTRB(
                AppSpacing.lg,
                AppSpacing.lg,
                AppSpacing.lg,
                MediaQuery.of(context).padding.bottom + AppSpacing.lg,
              ),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    Colors.black.withAlpha(179),
                  ],
                ),
              ),
              child: Builder(
                builder: (context) {
                  final l10n = AppLocalizations.of(context);
                  return Row(
                    children: [
                      // Retake button
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: _isSaving ? null : _retake,
                          icon: const Icon(Icons.refresh),
                          label: Text(l10n.retake),
                          style: OutlinedButton.styleFrom(
                            foregroundColor: Colors.white,
                            side: const BorderSide(color: Colors.white),
                            padding: const EdgeInsets.symmetric(
                              vertical: AppSpacing.md,
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(width: AppSpacing.md),

                      // Save button
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed:
                              _isSaving ? null : () => _savePhoto(args.imagePath),
                          icon: _isSaving
                              ? const SizedBox(
                                  width: 20,
                                  height: 20,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    color: Colors.white,
                                  ),
                                )
                              : const Icon(Icons.save_alt),
                          label: Text(l10n.save),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primary,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(
                              vertical: AppSpacing.md,
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
