import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

/// Splash screen that plays the starter video on first app launch.
class SplashScreen extends StatefulWidget {
  const SplashScreen({
    super.key,
    required this.onComplete,
  });

  /// Callback when video finishes or is skipped.
  final VoidCallback onComplete;

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  VideoPlayerController? _controller;
  bool _hasError = false;

  @override
  void initState() {
    super.initState();
    _initializeVideo();
  }

  Future<void> _initializeVideo() async {
    try {
      _controller = VideoPlayerController.asset('assets/icons/starter.mp4');
      await _controller!.initialize();
      
      if (!mounted) {
        _controller?.dispose();
        return;
      }
      
      setState(() {});
      
      // Play video
      await _controller!.play();
      
      // Listen for video completion
      _controller!.addListener(_onVideoStateChanged);
      
      _controller!.setLooping(false);
    } catch (e) {
      // If video fails to load, skip to app
      if (mounted) {
        setState(() => _hasError = true);
        // Wait a moment then proceed
        Future.delayed(const Duration(seconds: 1), () {
          if (mounted) {
            widget.onComplete();
          }
        });
      }
    }
  }

  void _onVideoStateChanged() {
    if (_controller != null &&
        _controller!.value.isInitialized &&
        _controller!.value.position.inMilliseconds > 0 &&
        _controller!.value.duration.inMilliseconds > 0 &&
        _controller!.value.position >= _controller!.value.duration) {
      // Video finished
      _controller!.removeListener(_onVideoStateChanged);
      if (mounted) {
        widget.onComplete();
      }
    }
  }

  void _skipVideo() {
    _controller?.removeListener(_onVideoStateChanged);
    _controller?.pause();
    widget.onComplete();
  }

  @override
  void dispose() {
    _controller?.removeListener(_onVideoStateChanged);
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Video player
          if (_controller != null &&
              _controller!.value.isInitialized &&
              !_hasError)
            Center(
              child: AspectRatio(
                aspectRatio: _controller!.value.aspectRatio,
                child: VideoPlayer(_controller!),
              ),
            )
          else
            // Fallback: show dog logo while loading or on error
            Center(
              child: Image.asset(
                'assets/icons/dog.png',
                width: 120,
                height: 120,
                fit: BoxFit.contain,
              ),
            ),

          // Skip button (top right)
          SafeArea(
            child: Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: TextButton(
                  onPressed: _skipVideo,
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.black.withAlpha(128),
                  ),
                  child: const Text('Skip'),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
