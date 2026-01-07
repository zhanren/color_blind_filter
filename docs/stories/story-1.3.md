# Story 1.3: Live Camera Preview with Protanopia Filter

**Epic:** 1 — Foundation & Live Filtered Camera  
**Status:** Ready for Review  
**Priority:** P0 — Core functionality  
**Estimate:** 3-4 hours  
**Depends On:** Story 1.2 (Permission Handling)

---

## Story

**As a** user,  
**I want** to see a live camera feed with a colorblind filter applied in real-time,  
**so that** I can point my phone at anything and instantly see how it looks to someone with color blindness.

---

## Acceptance Criteria

- [ ] AC1: Camera preview fills the screen in portrait orientation
- [ ] AC2: Preview displays at minimum 30 FPS on test device
- [ ] AC3: Protanopia color matrix filter is applied via `ColorFiltered` widget
- [ ] AC4: Filter visibly transforms colors (red objects appear different)
- [ ] AC5: Camera properly pauses when app goes to background
- [ ] AC6: Camera properly resumes when app returns to foreground
- [ ] AC7: "Protanopia" label displayed on screen indicating current mode
- [ ] AC8: No visible lag between camera movement and filtered preview

---

## Dev Notes

### Architecture Reference
- See `docs/architecture.md` Section 6.1 (Color Matrices)
- See `docs/architecture.md` Section 6.2 (Camera Service)

### Technical Details
- Use `camera` package for live preview
- Use `ColorFiltered` widget with `ColorFilter.matrix()` for filter
- Implement `WidgetsBindingObserver` for lifecycle handling
- Use `ResolutionPreset.medium` for balance of quality vs performance

### Key Patterns
```dart
// Apply color filter
ColorFiltered(
  colorFilter: ColorFilter.matrix(ColorMatrices.protanopia),
  child: CameraPreview(controller: _controller),
)

// Lifecycle handling
class _CameraScreenState extends State<CameraScreen> 
    with WidgetsBindingObserver {
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // Handle pause/resume
  }
}
```

---

## Tasks

### Task 1: Create Color Matrices Utility
- [x] 1.1 Create `lib/utils/color_matrices.dart`
- [x] 1.2 Add Protanopia matrix constant (5x4 = 20 elements)
- [x] 1.3 Add identity matrix for reference
- [x] 1.4 Document matrix source in comments
- [x] 1.5 Write unit tests for matrix structure

### Task 2: Create Camera Service
- [x] 2.1 Create `lib/utils/camera_service.dart`
- [x] 2.2 Implement `initialize()` method (back camera, medium resolution)
- [x] 2.3 Implement `dispose()` method
- [x] 2.4 Implement `pause()` and `resume()` methods
- [x] 2.5 Add error handling for camera initialization failures

### Task 3: Create Camera Preview Widget
- [x] 3.1 Create `lib/widgets/camera_preview.dart`
- [x] 3.2 Display camera preview using `CameraPreview` widget
- [x] 3.3 Wrap with `ColorFiltered` widget applying Protanopia matrix
- [x] 3.4 Handle not-initialized state gracefully

### Task 4: Update Camera Screen
- [x] 4.1 Replace placeholder content with actual camera preview
- [x] 4.2 Implement `WidgetsBindingObserver` for lifecycle
- [x] 4.3 Initialize camera on screen load
- [x] 4.4 Dispose camera on screen dispose
- [x] 4.5 Handle background/foreground transitions

### Task 5: Add Mode Label Overlay
- [x] 5.1 Create overlay showing "Protanopia" label
- [x] 5.2 Position at top of screen with semi-transparent background
- [x] 5.3 Style with app theme (AppColors.cameraOverlay)

### Task 6: Write Tests
- [x] 6.1 Unit test: Color matrices have correct length (20 elements)
- [x] 6.2 Unit test: Identity matrix values correct
- [x] 6.3 Widget test: CameraPreview widget structure
- [x] 6.4 Widget test: Mode label displays correctly

### Task 7: Validation
- [x] 7.1 Run `flutter analyze` — no errors ✅
- [x] 7.2 Run `flutter test` — 18 tests pass ✅
- [ ] 7.3 Manual test: Camera preview displays on real device
- [ ] 7.4 Manual test: Protanopia filter visibly changes colors
- [ ] 7.5 Manual test: App backgrounding pauses camera
- [ ] 7.6 Manual test: App foregrounding resumes camera
- [ ] 7.7 Manual test: No noticeable lag in preview

---

## Testing Requirements

### Unit Tests
- Color matrices have exactly 20 elements
- Identity matrix diagonal values are 1
- Alpha channel preserved in all matrices

### Widget Tests
- CameraPreview widget renders without error
- Mode label overlay displays "Protanopia"

### Manual Tests (Real Device Required)
- Camera preview at 30+ FPS
- Filter effect visible on colorful objects
- Lifecycle handling (background/foreground)

---

## Dev Agent Record

### Agent Model Used
Claude (James - Dev Agent)

### Debug Log References
- Fixed lint warnings: `final` → `const` for constant assignments in tests

### Completion Notes
- ColorMatrices utility created with all 4 colorblind types + identity matrix
- CameraService handles initialization, pause, resume, and disposal
- FilteredCameraPreview widget applies ColorFilter.matrix() to camera feed
- CameraScreen implements WidgetsBindingObserver for lifecycle handling
- Mode label overlay displays "Protanopia" at top of screen
- 18 tests passing (unit + widget tests)
- All automated validations pass

### File List
| Action | File Path |
|--------|-----------|
| Created | `lib/utils/color_matrices.dart` |
| Created | `lib/utils/camera_service.dart` |
| Created | `lib/widgets/camera_preview.dart` |
| Modified | `lib/screens/camera_screen.dart` |
| Created | `test/unit/color_matrices_test.dart` |
| Created | `test/unit/camera_service_test.dart` |
| Modified | `test/widget/camera_screen_test.dart` |
| Created | `test/widget/camera_preview_test.dart` |

### Change Log
| Date | Change | Author |
|------|--------|--------|
| Jan 3, 2026 | Story 1.3 implemented - Live camera preview with Protanopia filter | James (Dev Agent) |

---

*Story ready for development*
