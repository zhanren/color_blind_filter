import 'package:flutter/material.dart';

/// The two camera view modes available.
enum ViewMode {
  fullScreen,
  splitView,
}

/// Extension providing metadata for each view mode.
extension ViewModeExtension on ViewMode {
  /// Icon representing this view mode (shows what tapping will switch TO).
  IconData get icon {
    switch (this) {
      case ViewMode.fullScreen:
        return Icons.view_column; // Shows split icon when in full screen
      case ViewMode.splitView:
        return Icons.fullscreen; // Shows fullscreen icon when in split
    }
  }

  /// Label for this view mode.
  String get label {
    switch (this) {
      case ViewMode.fullScreen:
        return 'Full Screen';
      case ViewMode.splitView:
        return 'Split View';
    }
  }

  /// Returns the opposite mode (for toggling).
  ViewMode get toggled {
    switch (this) {
      case ViewMode.fullScreen:
        return ViewMode.splitView;
      case ViewMode.splitView:
        return ViewMode.fullScreen;
    }
  }
}
