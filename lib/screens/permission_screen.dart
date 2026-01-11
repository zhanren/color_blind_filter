import 'package:flutter/material.dart';

import '../l10n/app_localizations.dart';
import '../theme/app_colors.dart';
import '../theme/app_spacing.dart';
import '../utils/permissions.dart';

/// Screen that requests camera permission with a friendly explanation.
class PermissionScreen extends StatefulWidget {
  const PermissionScreen({super.key});

  @override
  State<PermissionScreen> createState() => _PermissionScreenState();
}

class _PermissionScreenState extends State<PermissionScreen> {
  bool _isLoading = true;
  bool _isDenied = false;
  bool _isPermanentlyDenied = false;

  @override
  void initState() {
    super.initState();
    _checkInitialPermission();
  }

  Future<void> _checkInitialPermission() async {
    final result = await PermissionService.checkCamera();

    if (!mounted) return;

    if (result == PermissionResult.granted) {
      _navigateToCamera();
    } else {
      setState(() {
        _isLoading = false;
        _isDenied = result == PermissionResult.denied ||
            result == PermissionResult.permanentlyDenied;
        _isPermanentlyDenied = result == PermissionResult.permanentlyDenied;
      });
    }
  }

  Future<void> _requestPermission() async {
    setState(() => _isLoading = true);

    final result = await PermissionService.requestCamera();

    if (!mounted) return;

    switch (result) {
      case PermissionResult.granted:
        _navigateToCamera();
      case PermissionResult.denied:
        setState(() {
          _isLoading = false;
          _isDenied = true;
          _isPermanentlyDenied = false;
        });
      case PermissionResult.permanentlyDenied:
      case PermissionResult.restricted:
        setState(() {
          _isLoading = false;
          _isDenied = true;
          _isPermanentlyDenied = true;
        });
    }
  }

  Future<void> _openSettings() async {
    await PermissionService.openSettings();
  }

  void _navigateToCamera() {
    Navigator.pushReplacementNamed(context, '/camera');
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return Scaffold(
        backgroundColor: AppColors.surface,
        body: Center(
          child: Image.asset(
            'assets/icons/dog.png',
            width: 80,
            height: 80,
            fit: BoxFit.contain,
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: AppColors.surface,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: _isDenied ? _buildDeniedContent() : _buildWelcomeContent(),
        ),
      ),
    );
  }

  Widget _buildWelcomeContent() {
    final l10n = AppLocalizations.of(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Spacer(),
        // App logo (dog.png)
        Container(
          width: 120,
          height: 120,
          decoration: BoxDecoration(
            color: AppColors.primary.withValues(alpha: 0.1),
            shape: BoxShape.circle,
          ),
          child: ClipOval(
            child: Image.asset(
              'assets/icons/dog.png',
              width: 120,
              height: 120,
              fit: BoxFit.cover,
            ),
          ),
        ),
        const SizedBox(height: AppSpacing.xl),
        // Title
        Text(
          l10n.welcomeTitle,
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                color: AppColors.onSurface,
                fontWeight: FontWeight.bold,
              ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: AppSpacing.md),
        // Explanation
        Text(
          l10n.welcomeSubtitle,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: AppColors.onSurface.withValues(alpha: 0.7),
              ),
          textAlign: TextAlign.center,
        ),
        const Spacer(),
        // Continue button
        SizedBox(
          width: double.infinity,
          height: AppSpacing.touchTarget,
          child: ElevatedButton(
            onPressed: _requestPermission,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              foregroundColor: AppColors.onPrimary,
            ),
            child: Text(l10n.enableCamera),
          ),
        ),
        const SizedBox(height: AppSpacing.lg),
      ],
    );
  }

  Widget _buildDeniedContent() {
    final l10n = AppLocalizations.of(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Spacer(),
        // Warning icon
        Container(
          width: 120,
          height: 120,
          decoration: BoxDecoration(
            color: AppColors.error.withValues(alpha: 0.1),
            shape: BoxShape.circle,
          ),
          child: const Icon(
            Icons.camera_alt_outlined,
            size: 60,
            color: AppColors.error,
          ),
        ),
        const SizedBox(height: AppSpacing.xl),
        // Title
        Text(
          l10n.permissionDenied,
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                color: AppColors.onSurface,
                fontWeight: FontWeight.bold,
              ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: AppSpacing.md),
        // Explanation
        Text(
          l10n.permissionDeniedDesc,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: AppColors.onSurface.withValues(alpha: 0.7),
              ),
          textAlign: TextAlign.center,
        ),
        const Spacer(),
        // Buttons
        if (_isPermanentlyDenied) ...[
          SizedBox(
            width: double.infinity,
            height: AppSpacing.touchTarget,
            child: ElevatedButton(
              onPressed: _openSettings,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: AppColors.onPrimary,
              ),
              child: Text(l10n.openSettings),
            ),
          ),
        ] else ...[
          SizedBox(
            width: double.infinity,
            height: AppSpacing.touchTarget,
            child: ElevatedButton(
              onPressed: _requestPermission,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: AppColors.onPrimary,
              ),
              child: Text(l10n.enableCamera),
            ),
          ),
        ],
        const SizedBox(height: AppSpacing.lg),
      ],
    );
  }
}
