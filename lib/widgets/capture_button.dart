import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

/// A prominent circular button for capturing photos.
class CaptureButton extends StatefulWidget {
  const CaptureButton({
    super.key,
    required this.onPressed,
    this.isCapturing = false,
  });

  /// Callback when the button is pressed.
  final VoidCallback onPressed;

  /// Whether a capture is currently in progress.
  final bool isCapturing;

  @override
  State<CaptureButton> createState() => _CaptureButtonState();
}

class _CaptureButtonState extends State<CaptureButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 100),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.9).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _handleTapDown(TapDownDetails details) {
    _animationController.forward();
  }

  void _handleTapUp(TapUpDetails details) {
    _animationController.reverse();
    if (!widget.isCapturing) {
      widget.onPressed();
    }
  }

  void _handleTapCancel() {
    _animationController.reverse();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: _handleTapDown,
      onTapUp: _handleTapUp,
      onTapCancel: _handleTapCancel,
      child: AnimatedBuilder(
        animation: _scaleAnimation,
        builder: (context, child) {
          return Transform.scale(
            scale: _scaleAnimation.value,
            child: child,
          );
        },
        child: Container(
          width: 72,
          height: 72,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white,
            border: Border.all(
              color: AppColors.primary,
              width: 4,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withAlpha(64),
                blurRadius: 8,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Center(
            child: widget.isCapturing
                ? const SizedBox(
                    width: 32,
                    height: 32,
                    child: CircularProgressIndicator(
                      strokeWidth: 3,
                      color: AppColors.primary,
                    ),
                  )
                : const Icon(
                    Icons.camera_alt,
                    color: AppColors.primary,
                    size: 32,
                  ),
          ),
        ),
      ),
    );
  }
}
