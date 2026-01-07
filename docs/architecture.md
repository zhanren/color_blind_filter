# Color Blind Filter — Architecture Document

**Version:** 0.1  
**Last Updated:** January 3, 2026  
**Author:** Architect Winston

---

## 1. Introduction

This document outlines the architecture for the Color Blind Filter mobile app — a Flutter-based camera application that simulates colorblind vision in real-time. It serves as the technical guide for AI-driven development.

### 1.1 Starter Template

**Decision: No starter template — standard `flutter create` approach**

- Flutter's default project structure suits this app size
- Custom folder organization per PRD section 4.1
- Keeps dependencies minimal (learning project goal)

### 1.2 Change Log

| Date | Version | Description | Author |
|------|---------|-------------|--------|
| Jan 3, 2026 | 0.1 | Initial architecture document | Architect Winston |

---

## 2. Tech Stack

| Category | Technology | Version | Purpose | Rationale |
|----------|------------|---------|---------|-----------|
| **Framework** | Flutter | 3.24.x | Cross-platform mobile UI | PRD requirement; single codebase for iOS + Android |
| **Language** | Dart | 3.5.x | Application logic | Flutter's native language; strong typing, null safety |
| **Camera** | `camera` | ^0.11.0 | Live camera preview and capture | Official Flutter team package |
| **Permissions** | `permission_handler` | ^11.3.0 | Camera/storage permission management | Cross-platform permission API |
| **Image Save** | `image_gallery_saver` | ^2.0.3 | Save photos to device gallery | Simple API for gallery integration |
| **State Management** | `setState` + `ChangeNotifier` | Built-in | Manage filter mode and UI state | Minimal state; no heavy library needed |
| **Routing** | Navigator 2.0 | Built-in | Screen navigation | Only 2-3 screens; built-in sufficient |
| **Styling** | Flutter Themes | Built-in | UI theming and components | Custom widgets for brand consistency |
| **Testing** | `flutter_test` | Built-in | Unit and widget tests | Official testing framework |
| **Fonts** | `google_fonts` | ^6.2.0 | Nunito typography | PRD specifies rounded, friendly sans-serif |
| **Icons** | `flutter_svg` | ^2.0.10 | SVG animal icons | Custom animal silhouettes |

---

## 3. Project Structure

```
color_blind_filter/
├── android/                          # Android platform code
│   ├── app/
│   │   └── src/main/
│   │       └── AndroidManifest.xml   # Camera permission declaration
│   └── build.gradle
├── ios/                              # iOS platform code
│   ├── Runner/
│   │   └── Info.plist                # NSCameraUsageDescription
│   └── Podfile
├── lib/                              # Dart source code
│   ├── main.dart                     # App entry point
│   ├── app.dart                      # MaterialApp configuration
│   │
│   ├── screens/                      # Full-page screens
│   │   ├── permission_screen.dart    # Camera permission request flow
│   │   ├── camera_screen.dart        # Main camera view with filters
│   │   └── photo_review_screen.dart  # Capture review with save/retake
│   │
│   ├── widgets/                      # Reusable UI components
│   │   ├── mode_switcher.dart        # 4-button filter selector
│   │   ├── animal_info_sheet.dart    # Bottom sheet with animal facts
│   │   ├── animal_icon.dart          # Tappable animal icon overlay
│   │   ├── capture_button.dart       # Shutter button with animation
│   │   ├── split_view_toggle.dart    # Full/split view toggle
│   │   └── camera_preview.dart       # Filtered camera preview widget
│   │
│   ├── models/                       # Data models
│   │   ├── filter_mode.dart          # Enum + metadata for 4 filter types
│   │   └── animal_info.dart          # Animal name, icon, fun fact
│   │
│   ├── utils/                        # Utilities and constants
│   │   ├── color_matrices.dart       # 4 colorblind filter matrices
│   │   ├── camera_service.dart       # Camera initialization and capture
│   │   ├── permissions.dart          # Permission helper functions
│   │   ├── gallery_service.dart      # Save images to gallery
│   │   ├── navigation.dart           # Navigation helpers
│   │   └── constants.dart            # App-wide constants
│   │
│   └── theme/                        # Theming
│       ├── app_theme.dart            # ThemeData configuration
│       ├── app_colors.dart           # Color palette constants
│       └── app_spacing.dart          # Spacing system
│
├── assets/                           # Static assets
│   ├── icons/                        # Animal SVG icons
│   │   ├── dog.svg                   # Protanopia
│   │   ├── mouse.svg                 # Deuteranopia
│   │   ├── whale.svg                 # Tritanopia
│   │   └── owl.svg                   # Achromatopsia
│   └── fonts/                        # (if bundling fonts locally)
│
├── test/                             # Test files
│   ├── unit/                         # Unit tests
│   │   └── color_matrices_test.dart
│   ├── widget/                       # Widget tests
│   │   ├── mode_switcher_test.dart
│   │   └── animal_info_sheet_test.dart
│   └── screen/                       # Screen tests
│
├── docs/                             # Documentation
├── pubspec.yaml                      # Dependencies and assets
├── analysis_options.yaml             # Dart linter rules
└── README.md                         # Setup instructions
```

---

## 4. Component Standards

### 4.1 Widget Template

```dart
import 'package:flutter/material.dart';

/// Brief description of what this widget does.
class ExampleWidget extends StatelessWidget {
  const ExampleWidget({
    super.key,
    required this.title,
    this.onTap,
    this.isActive = false,
  });

  final String title;
  final VoidCallback? onTap;
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isActive ? theme.colorScheme.primary : theme.colorScheme.surface,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text(
          title,
          style: theme.textTheme.labelLarge,
        ),
      ),
    );
  }
}
```

### 4.2 Naming Conventions

| Element | Convention | Example |
|---------|------------|---------|
| Widget class | PascalCase | `ModeSwitcher` |
| Widget file | snake_case | `mode_switcher.dart` |
| State class | `_WidgetNameState` | `_CameraScreenState` |
| Callbacks | `on` + action | `onTap`, `onModeChanged` |
| Boolean props | `is` or `has` prefix | `isActive`, `hasError` |
| Private members | `_` prefix | `_currentMode` |
| Enums | PascalCase, singular | `FilterMode.protanopia` |

---

## 5. State Management

### 5.1 State Architecture

```
┌─────────────────────────────────────────────────────────┐
│                      App State                          │
│  - currentFilterMode (FilterMode enum)                  │
│  - viewMode (fullScreen/splitView)                      │
│  - cameraController (CameraController?)                 │
│  - isCapturing (bool)                                   │
│                                                         │
│  Location: CameraScreen (StatefulWidget)                │
└─────────────────────────────────────────────────────────┘
```

### 5.2 Filter Mode Model

```dart
// lib/models/filter_mode.dart

enum FilterMode {
  protanopia,
  deuteranopia,
  tritanopia,
  achromatopsia,
}

extension FilterModeExtension on FilterMode {
  String get displayName => switch (this) {
    FilterMode.protanopia => 'Protanopia',
    FilterMode.deuteranopia => 'Deuteranopia',
    FilterMode.tritanopia => 'Tritanopia',
    FilterMode.achromatopsia => 'Achromatopsia',
  };

  String get shortName => switch (this) {
    FilterMode.protanopia => 'Red-blind',
    FilterMode.deuteranopia => 'Green-blind',
    FilterMode.tritanopia => 'Blue-blind',
    FilterMode.achromatopsia => 'Monochrome',
  };

  String get animalIconPath => 'assets/icons/${name}.svg';

  List<double> get colorMatrix => ColorMatrices.forMode(this);
}
```

---

## 6. Platform Integration

### 6.1 Color Matrices

```dart
// lib/utils/color_matrices.dart

/// Scientifically-sourced color matrices for colorblind simulation.
/// Format: 5x4 (20 element) array for ColorFilter.matrix()
abstract class ColorMatrices {
  ColorMatrices._();

  /// Protanopia (Red-blind) - Dogs, cats, cattle
  static const List<double> protanopia = [
    0.567, 0.433, 0.000, 0, 0,
    0.558, 0.442, 0.000, 0, 0,
    0.000, 0.242, 0.758, 0, 0,
    0,     0,     0,     1, 0,
  ];

  /// Deuteranopia (Green-blind) - Most mammals, mice, rats
  static const List<double> deuteranopia = [
    0.625, 0.375, 0.000, 0, 0,
    0.700, 0.300, 0.000, 0, 0,
    0.000, 0.300, 0.700, 0, 0,
    0,     0,     0,     1, 0,
  ];

  /// Tritanopia (Blue-blind) - Some whales
  static const List<double> tritanopia = [
    0.950, 0.050, 0.000, 0, 0,
    0.000, 0.433, 0.567, 0, 0,
    0.000, 0.475, 0.525, 0, 0,
    0,     0,     0,     1, 0,
  ];

  /// Achromatopsia (Monochromacy) - Owls, bats, raccoons
  static const List<double> achromatopsia = [
    0.299, 0.587, 0.114, 0, 0,
    0.299, 0.587, 0.114, 0, 0,
    0.299, 0.587, 0.114, 0, 0,
    0,     0,     0,     1, 0,
  ];

  /// Identity matrix (normal vision)
  static const List<double> identity = [
    1, 0, 0, 0, 0,
    0, 1, 0, 0, 0,
    0, 0, 1, 0, 0,
    0, 0, 0, 1, 0,
  ];

  static List<double> forMode(FilterMode mode) => switch (mode) {
    FilterMode.protanopia => protanopia,
    FilterMode.deuteranopia => deuteranopia,
    FilterMode.tritanopia => tritanopia,
    FilterMode.achromatopsia => achromatopsia,
  };
}
```

### 6.2 Camera Service

```dart
// lib/utils/camera_service.dart

import 'package:camera/camera.dart';

class CameraService {
  CameraController? _controller;

  bool get isInitialized => _controller?.value.isInitialized ?? false;
  CameraController? get controller => _controller;

  Future<void> initialize() async {
    final cameras = await availableCameras();
    final backCamera = cameras.firstWhere(
      (c) => c.lensDirection == CameraLensDirection.back,
      orElse: () => cameras.first,
    );

    _controller = CameraController(
      backCamera,
      ResolutionPreset.medium,
      enableAudio: false,
    );

    await _controller!.initialize();
  }

  Future<String?> capturePhoto() async {
    if (!isInitialized) return null;
    try {
      final image = await _controller!.takePicture();
      return image.path;
    } catch (e) {
      return null;
    }
  }

  Future<void> dispose() async {
    await _controller?.dispose();
    _controller = null;
  }
}
```

### 6.3 Permission Service

```dart
// lib/utils/permissions.dart

import 'package:permission_handler/permission_handler.dart';

enum PermissionResult { granted, denied, permanentlyDenied, restricted }

class PermissionService {
  static Future<PermissionResult> requestCamera() async {
    final status = await Permission.camera.status;
    
    if (status.isGranted) return PermissionResult.granted;
    if (status.isPermanentlyDenied) return PermissionResult.permanentlyDenied;
    if (status.isRestricted) return PermissionResult.restricted;

    final result = await Permission.camera.request();
    
    if (result.isGranted) return PermissionResult.granted;
    if (result.isPermanentlyDenied) return PermissionResult.permanentlyDenied;
    return PermissionResult.denied;
  }

  static Future<PermissionResult> requestPhotos() async {
    final status = await Permission.photos.status;
    if (status.isGranted) return PermissionResult.granted;
    
    final result = await Permission.photos.request();
    if (result.isGranted) return PermissionResult.granted;
    if (result.isPermanentlyDenied) return PermissionResult.permanentlyDenied;
    return PermissionResult.denied;
  }

  static Future<bool> openSettings() => openAppSettings();
}
```

---

## 7. Routing

### 7.1 Route Configuration

```dart
// lib/app.dart

import 'package:flutter/material.dart';
import 'screens/permission_screen.dart';
import 'screens/camera_screen.dart';
import 'screens/photo_review_screen.dart';
import 'theme/app_theme.dart';

class ColorBlindFilterApp extends StatelessWidget {
  const ColorBlindFilterApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Color Blind Filter',
      theme: AppTheme.light,
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => const PermissionScreen(),
        '/camera': (context) => const CameraScreen(),
      },
      onGenerateRoute: (settings) {
        if (settings.name == '/review') {
          final imagePath = settings.arguments as String?;
          return MaterialPageRoute(
            builder: (context) => PhotoReviewScreen(imagePath: imagePath),
          );
        }
        return null;
      },
    );
  }
}
```

### 7.2 Navigation Flow

```
PermissionScreen ──(granted)──▶ CameraScreen ──(capture)──▶ PhotoReviewScreen
       │                              ▲                            │
       │                              └────────(retake)────────────┘
       └──(denied)──▶ Settings App
```

---

## 8. Styling

### 8.1 Color Palette

```dart
// lib/theme/app_colors.dart

import 'package:flutter/material.dart';

abstract class AppColors {
  AppColors._();

  // Primary - Teal (visible in all colorblind modes)
  static const Color primary = Color(0xFF00B4A0);
  static const Color onPrimary = Color(0xFFFFFFFF);
  
  // Secondary - Amber
  static const Color secondary = Color(0xFFFFB74D);
  static const Color onSecondary = Color(0xFF1A1A1A);

  // Neutrals
  static const Color surface = Color(0xFFF8F9FA);
  static const Color onSurface = Color(0xFF1A1A1A);
  
  // Filter mode colors (distinct in colorblind simulation)
  static const Color filterProtanopia = Color(0xFF2196F3);
  static const Color filterDeuteranopia = Color(0xFF9C27B0);
  static const Color filterTritanopia = Color(0xFFFF9800);
  static const Color filterAchromatopsia = Color(0xFF616161);

  // Overlay
  static const Color cameraOverlay = Color(0x99000000);
  static const Color badge = Color(0xE6FFFFFF);
}
```

### 8.2 Spacing System

```dart
// lib/theme/app_spacing.dart

abstract class AppSpacing {
  AppSpacing._();

  static const double xs = 4;
  static const double sm = 8;
  static const double md = 16;
  static const double lg = 24;
  static const double xl = 32;

  /// Minimum touch target size (NFR4)
  static const double touchTarget = 44;
  
  static const double radiusSm = 8;
  static const double radiusMd = 12;
  static const double radiusLg = 16;
}
```

### 8.3 Theme Configuration

```dart
// lib/theme/app_theme.dart

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

abstract class AppTheme {
  AppTheme._();

  static ThemeData get light => ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.primary,
      primary: AppColors.primary,
      secondary: AppColors.secondary,
    ),
    textTheme: GoogleFonts.nunitoTextTheme(),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        minimumSize: const Size(44, 44),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
    ),
  );
}
```

---

## 9. Testing

### 9.1 Test Structure

```
test/
├── unit/
│   ├── color_matrices_test.dart
│   ├── filter_mode_test.dart
│   └── permissions_test.dart
├── widget/
│   ├── mode_switcher_test.dart
│   ├── animal_info_sheet_test.dart
│   └── capture_button_test.dart
└── screen/
    ├── permission_screen_test.dart
    └── photo_review_screen_test.dart
```

### 9.2 Coverage Goals

| Test Type | Target |
|-----------|--------|
| Unit tests | 90%+ |
| Widget tests | 80%+ |
| Screen tests | 60%+ |
| Integration | Manual (camera) |

### 9.3 Manual Testing Checklist

| Test Case | iOS | Android |
|-----------|-----|---------|
| Camera preview displays | ☐ | ☐ |
| All 4 filters apply | ☐ | ☐ |
| Filter switch < 100ms | ☐ | ☐ |
| Side-by-side view | ☐ | ☐ |
| Photo capture works | ☐ | ☐ |
| Photo saves to gallery | ☐ | ☐ |
| Background/foreground | ☐ | ☐ |

---

## 10. Environment Configuration

### 10.1 pubspec.yaml

```yaml
name: color_blind_filter
description: See the world through colorblind and animal eyes

environment:
  sdk: '>=3.5.0 <4.0.0'
  flutter: '>=3.24.0'

dependencies:
  flutter:
    sdk: flutter
  camera: ^0.11.0
  permission_handler: ^11.3.0
  image_gallery_saver: ^2.0.3
  google_fonts: ^6.2.0
  flutter_svg: ^2.0.10

dev_dependencies:
  flutter_test:
    sdk: flutter
  flutter_lints: ^4.0.0

flutter:
  uses-material-design: true
  assets:
    - assets/icons/
```

### 10.2 Platform Configuration

**iOS (Info.plist):**
- `NSCameraUsageDescription`: "We need camera access to show you colorblind vision"
- `NSPhotoLibraryAddUsageDescription`: "Save photos to share with friends"
- Minimum iOS: 12.0

**Android (AndroidManifest.xml):**
- `android.permission.CAMERA`
- `android.permission.WRITE_EXTERNAL_STORAGE` (maxSdkVersion=32)
- `android.permission.READ_MEDIA_IMAGES`
- Minimum SDK: 21

---

## 11. Critical Coding Rules

| # | Rule |
|---|------|
| 1 | Always use `const` constructors |
| 2 | Access colors via `Theme.of(context)` |
| 3 | All touch targets ≥ 44pt |
| 4 | Dispose controllers in `dispose()` |
| 5 | Check `mounted` before `setState` |
| 6 | Use `super.key` in constructors |
| 7 | Color matrices are constants — never modify |
| 8 | No `print()` — use `debugPrint()` |

---

## 12. Quick Reference

### Commands

```bash
flutter pub get       # Install dependencies
flutter run           # Run on device
flutter test          # Run tests
flutter build apk     # Build Android
flutter build ios     # Build iOS
flutter analyze       # Lint check
```

### Widget Inventory

| Widget | File | Purpose |
|--------|------|---------|
| `ModeSwitcher` | `widgets/mode_switcher.dart` | 4-button filter selector |
| `CameraPreview` | `widgets/camera_preview.dart` | Filtered camera feed |
| `AnimalIcon` | `widgets/animal_icon.dart` | Tappable animal indicator |
| `AnimalInfoSheet` | `widgets/animal_info_sheet.dart` | Bottom sheet with facts |
| `CaptureButton` | `widgets/capture_button.dart` | Shutter button |
| `SplitViewToggle` | `widgets/split_view_toggle.dart` | Full/split toggle |

### Applying Color Filter

```dart
ColorFiltered(
  colorFilter: ColorFilter.matrix(currentFilter.colorMatrix),
  child: CameraPreview(controller: _cameraController),
)
```

---

*Document generated using BMAD-METHOD™ Architecture workflow*
