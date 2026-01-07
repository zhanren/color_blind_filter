# Story 5.3: Pinch to Zoom Camera

**Epic:** Epic 5 – UX Improvements  
**Priority:** Medium  
**Points:** 2

## Description

Allow users to zoom in and out on the camera preview using a two-finger pinch gesture, similar to the native camera app.

## Acceptance Criteria

- [ ] Pinch out (spread fingers) zooms in
- [ ] Pinch in (bring fingers together) zooms out
- [ ] Zoom level is smooth and responsive
- [ ] Zoom resets when switching cameras
- [ ] Zoom works in both full screen and split view modes
- [ ] Zoom level indicator shows current zoom (optional)
- [ ] Respects device min/max zoom limits

## Technical Implementation

### Files to Modify

| File | Change |
|------|--------|
| `lib/utils/camera_service.dart` | Add zoom methods and state |
| `lib/screens/camera_screen.dart` | Add GestureDetector for pinch |
| `lib/widgets/camera_preview.dart` | (Optional) Show zoom indicator |

### CameraService API

```dart
// Current zoom level (1.0 = no zoom)
double get currentZoom;

// Min/max zoom supported by device
double get minZoom;
double get maxZoom;

// Set zoom level
Future<void> setZoom(double zoom);
```

### Gesture Detection

Use `ScaleGestureRecognizer` or `GestureDetector.onScaleUpdate`:

```dart
GestureDetector(
  onScaleStart: (details) => _baseZoom = _currentZoom,
  onScaleUpdate: (details) {
    final newZoom = (_baseZoom * details.scale).clamp(minZoom, maxZoom);
    _cameraService.setZoom(newZoom);
  },
)
```

### Camera Package Support

The `camera` package supports zoom via:
- `CameraController.getMinZoomLevel()`
- `CameraController.getMaxZoomLevel()`
- `CameraController.setZoomLevel(double)`

## Status: Complete
