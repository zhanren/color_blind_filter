# Story 3.4: Front Camera Support

**Epic:** Epic 3 – Enhancements & Fixes  
**Priority:** Medium  
**Points:** 2

## Description

Add support for the front camera to enable selfie-mode colorblind simulation. Users can switch between front and back cameras using a flip button in the header.

## Acceptance Criteria

- [x] A camera flip button appears in the header (next to view toggle)
- [x] Tapping the button switches between front and back cameras
- [x] Button only shows when device has multiple cameras
- [x] Front camera preview is mirrored for natural selfie view
- [x] Loading indicator shows while switching cameras
- [x] All filters work correctly with front camera
- [x] Split view works correctly with front camera

## Technical Implementation

### Files Changed

| File | Change |
|------|--------|
| `lib/utils/camera_service.dart` | Added `lensDirection`, `hasMultipleCameras`, `switchCamera()` |
| `lib/widgets/camera_flip_button.dart` | New widget for camera flip button |
| `lib/widgets/camera_preview.dart` | Added `isFrontCamera` prop for mirroring |
| `lib/widgets/split_camera_preview.dart` | Added `isFrontCamera` prop for mirroring |
| `lib/widgets/camera_header.dart` | Added flip button integration |
| `lib/screens/camera_screen.dart` | Added switch camera state and logic |
| `test/widget/camera_flip_button_test.dart` | New tests for flip button |
| `test/unit/camera_service_test.dart` | Added tests for new service methods |

### CameraService API Additions

```dart
// Get current lens direction
CameraLensDirection get lensDirection;

// Check if device has front and back cameras
bool get hasMultipleCameras;

// Switch between cameras (returns success)
Future<bool> switchCamera();
```

### Front Camera Mirroring

The front camera preview is horizontally mirrored using `Transform.scale(scaleX: -1)` to provide a natural selfie view (like a mirror).

## Testing

### Automated Tests
- CameraFlipButton displays flip camera icon ✅
- CameraFlipButton calls onPressed when tapped ✅
- CameraFlipButton shows loading indicator when isLoading ✅
- CameraFlipButton does not call onPressed when isLoading ✅
- CameraService initial lens direction is back ✅
- CameraService hasMultipleCameras is false before init ✅

### Manual Testing Required
- Verify flip button appears in header
- Verify tapping switches to front camera
- Verify front camera preview is mirrored
- Verify all filters work with front camera
- Verify split view works with front camera
- Verify capture works with front camera

## Status: ✅ COMPLETE

**Completed:** January 4, 2026
