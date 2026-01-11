import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

import '../l10n/app_localizations.dart';
import '../models/filter_mode.dart';
import '../models/view_mode.dart';
import '../theme/app_colors.dart';
import '../theme/app_spacing.dart';
import '../utils/camera_service.dart';
import '../utils/screenshot_service.dart';
import '../widgets/animal_info_sheet.dart';
import '../widgets/camera_header.dart';
import '../widgets/camera_preview.dart';
import '../widgets/capture_button.dart';
import '../widgets/mode_switcher.dart';
import '../widgets/split_camera_preview.dart';
import 'review_screen.dart';

/// Main camera screen with live filtered preview.
class CameraScreen extends StatefulWidget {
  const CameraScreen({
    super.key,
    this.onLocaleChanged,
  });

  /// Callback when the locale is changed in settings.
  final void Function(Locale)? onLocaleChanged;

  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen>
    with WidgetsBindingObserver, SingleTickerProviderStateMixin {
  final CameraService _cameraService = CameraService();
  final GlobalKey _previewKey = GlobalKey();
  bool _isInitializing = true;
  bool _isCapturing = false;
  bool _isSwitchingCamera = false;
  bool _controlsVisible = true;
  String? _errorMessage;
  FilterMode _currentFilter = FilterMode.protanopia;
  ViewMode _viewMode = ViewMode.fullScreen;
  
  // Zoom state for pinch gesture
  double _baseZoom = 1.0;

  // Animation duration for controls hide/show
  static const _animationDuration = Duration(milliseconds: 250);

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _initializeCamera();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _cameraService.dispose();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // Handle app lifecycle changes
    if (!_cameraService.isInitialized) return;

    switch (state) {
      case AppLifecycleState.inactive:
      case AppLifecycleState.paused:
        _cameraService.pause();
      case AppLifecycleState.resumed:
        _cameraService.resume();
      case AppLifecycleState.detached:
      case AppLifecycleState.hidden:
        // No action needed
        break;
    }
  }

  Future<void> _initializeCamera() async {
    try {
      await _cameraService.initialize();
      if (mounted) {
        setState(() {
          _isInitializing = false;
          _errorMessage = null;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _isInitializing = false;
          _errorMessage = 'Failed to initialize camera: $e';
        });
      }
    }
  }

  void _onFilterChanged(FilterMode mode) {
    setState(() => _currentFilter = mode);
  }

  void _showAnimalInfo() {
    AnimalInfoSheet.show(context, _currentFilter.localizedAnimalInfo(context));
  }

  void _toggleViewMode() {
    setState(() => _viewMode = _viewMode.toggled);
  }

  void _hideControls() {
    if (_controlsVisible) {
      setState(() => _controlsVisible = false);
    }
  }

  void _showControls() {
    if (!_controlsVisible) {
      setState(() => _controlsVisible = true);
    }
  }

  void _onScaleStart(ScaleStartDetails details) {
    // Capture current zoom as base for pinch gesture
    _baseZoom = _cameraService.currentZoom;
  }

  void _onScaleUpdate(ScaleUpdateDetails details) {
    // Handle pinch to zoom
    if (details.scale != 1.0) {
      final newZoom = (_baseZoom * details.scale).clamp(
        _cameraService.minZoom,
        _cameraService.maxZoom,
      );
      _cameraService.setZoom(newZoom);
    }
  }

  void _onScaleEnd(ScaleEndDetails details) {
    // Handle vertical swipe for showing/hiding controls
    final velocityY = details.velocity.pixelsPerSecond.dy;
    if (velocityY > 300) {
      // Swipe down
      _hideControls();
    } else if (velocityY < -300) {
      // Swipe up
      _showControls();
    }
  }

  void _onTapUp(TapUpDetails details) {
    // Tap to show controls when hidden
    if (!_controlsVisible) {
      _showControls();
    }
  }

  Future<void> _switchCamera() async {
    if (_isSwitchingCamera) return;

    setState(() => _isSwitchingCamera = true);

    try {
      final success = await _cameraService.switchCamera();
      if (mounted && !success) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(AppLocalizations.of(context).captureFailed),
            backgroundColor: AppColors.error,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isSwitchingCamera = false);
      }
    }
  }

  bool get _isFrontCamera =>
      _cameraService.lensDirection == CameraLensDirection.front;

  Future<void> _openSettings() async {
    final result = await Navigator.of(context).pushNamed('/settings');
    if (result is Locale && widget.onLocaleChanged != null) {
      widget.onLocaleChanged!(result);
    }
  }

  Future<void> _capturePhoto() async {
    if (_isCapturing) return;

    setState(() => _isCapturing = true);

    try {
      // Capture screenshot of the filtered preview
      final imagePath = await ScreenshotService.capture(_previewKey);

      if (imagePath != null && mounted) {
        // Navigate to review screen
        await Navigator.of(context).pushNamed(
          '/review',
          arguments: ReviewScreenArgs(
            imagePath: imagePath,
            filterMode: _currentFilter,
          ),
        );
      } else if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(AppLocalizations.of(context).captureFailed),
            backgroundColor: AppColors.error,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isCapturing = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    final safePadding = MediaQuery.of(context).padding;

    return Scaffold(
      backgroundColor: Colors.black,
      body: GestureDetector(
        onScaleStart: _onScaleStart,
        onScaleUpdate: _onScaleUpdate,
        onScaleEnd: _onScaleEnd,
        onTapUp: _onTapUp,
        behavior: HitTestBehavior.translucent,
        child: Stack(
          fit: StackFit.expand,
          children: [
            // Camera preview (wrapped in RepaintBoundary for screenshot capture)
            RepaintBoundary(
              key: _previewKey,
              child: _buildCameraPreview(),
            ),

            // Header bar at top (animated)
            AnimatedPositioned(
              duration: _animationDuration,
              curve: Curves.easeInOut,
              top: _controlsVisible ? 0 : -120,
              left: 0,
              right: 0,
              child: CameraHeader(
                filterMode: _currentFilter,
                viewMode: _viewMode,
                onViewToggle: _toggleViewMode,
                onAnimalTap: _showAnimalInfo,
                onSettingsTap: _openSettings,
                showModeLabel: _viewMode == ViewMode.fullScreen,
                showCameraFlip: _cameraService.hasMultipleCameras,
                onCameraFlip: _switchCamera,
                isSwitchingCamera: _isSwitchingCamera,
              ),
            ),

            // Capture button and mode switcher - layout depends on orientation
            if (isLandscape) ...[
              // Landscape: Controls on right side (always visible)
              Positioned(
                right: safePadding.right + AppSpacing.md,
                top: 0,
                bottom: 0,
                child: Center(
                  child: CaptureButton(
                    onPressed: _capturePhoto,
                    isCapturing: _isCapturing,
                  ),
                ),
              ),
              // Mode switcher at bottom in landscape (animated)
              AnimatedPositioned(
                duration: _animationDuration,
                curve: Curves.easeInOut,
                left: safePadding.left,
                right: safePadding.right + 100,
                bottom: _controlsVisible ? 0 : -120,
                child: ModeSwitcher(
                  currentMode: _currentFilter,
                  onModeChanged: _onFilterChanged,
                ),
              ),
            ] else ...[
              // Portrait: Capture button (always visible, adjusts position)
              AnimatedPositioned(
                duration: _animationDuration,
                curve: Curves.easeInOut,
                left: 0,
                right: 0,
                bottom: _controlsVisible ? 120 : 40,
                child: Center(
                  child: CaptureButton(
                    onPressed: _capturePhoto,
                    isCapturing: _isCapturing,
                  ),
                ),
              ),
              // Mode switcher at bottom (animated)
              AnimatedPositioned(
                duration: _animationDuration,
                curve: Curves.easeInOut,
                left: 0,
                right: 0,
                bottom: _controlsVisible ? 0 : -120,
                child: ModeSwitcher(
                  currentMode: _currentFilter,
                  onModeChanged: _onFilterChanged,
                ),
              ),
            ],

            // Handle indicator when controls are hidden
            if (!_controlsVisible)
              Positioned(
                left: 0,
                right: 0,
                bottom: 8,
                child: Center(
                  child: AnimatedOpacity(
                    duration: _animationDuration,
                    opacity: _controlsVisible ? 0 : 1,
                    child: Container(
                      width: 40,
                      height: 4,
                      decoration: BoxDecoration(
                        color: Colors.white.withAlpha(128),
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  ),
                ),
              ),

            // Error overlay
            if (_errorMessage != null) _buildErrorOverlay(),
          ],
        ),
      ),
    );
  }

  Widget _buildCameraPreview() {
    if (_isInitializing) {
      return Center(
        child: Image.asset(
          'assets/icons/dog.png',
          width: 80,
          height: 80,
          fit: BoxFit.contain,
        ),
      );
    }

    if (_cameraService.controller == null) {
      return const Center(
        child: Text(
          'Camera not available',
          style: TextStyle(color: Colors.white),
        ),
      );
    }

    // Split view: show normal + filtered side by side
    if (_viewMode == ViewMode.splitView) {
      return SplitCameraPreview(
        controller: _cameraService.controller!,
        filterMode: _currentFilter,
        isFrontCamera: _isFrontCamera,
      );
    }

    // Full screen: show filtered only
    return FilteredCameraPreview(
      controller: _cameraService.controller!,
      colorMatrix: _currentFilter.colorMatrix,
      isFrontCamera: _isFrontCamera,
    );
  }

  Widget _buildErrorOverlay() {
    return Container(
      color: Colors.black87,
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.error_outline,
                color: AppColors.error,
                size: 48,
              ),
              const SizedBox(height: AppSpacing.md),
              Text(
                _errorMessage!,
                style: const TextStyle(color: Colors.white),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: AppSpacing.lg),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    _isInitializing = true;
                    _errorMessage = null;
                  });
                  _initializeCamera();
                },
                child: const Text('Retry'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
