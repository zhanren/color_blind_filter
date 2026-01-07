# Story 3.2: Responsive Split View (Landscape Support)

**Epic:** 3 — Polish & Enhancements  
**Status:** Ready for Development  
**Priority:** P1 — UX improvement  
**Estimate:** 2 hours  
**Depends On:** Story 2.2

---

## Story

**As a** user,  
**I want** the split view to adapt to my phone's orientation,  
**so that** I get the best comparison view whether holding my phone vertically or horizontally.

---

## Problem

Current split view is always vertical (left/right). When phone is rotated to landscape, the comparison should be horizontal (top/bottom) to better utilize screen space.

---

## Acceptance Criteria

- [ ] AC1: In portrait mode, split view shows left (Normal) / right (Filtered)
- [ ] AC2: In landscape mode, split view shows top (Normal) / bottom (Filtered)
- [ ] AC3: App supports both portrait and landscape orientations
- [ ] AC4: Transition between orientations is smooth
- [ ] AC5: All overlays (buttons, labels) remain accessible in both orientations

---

## Tasks

### Task 1: Enable Landscape Orientation
- [ ] 1.1 Update iOS Info.plist to allow landscape orientations
- [ ] 1.2 Update Android AndroidManifest.xml to allow landscape
- [ ] 1.3 Remove `screenOrientation="portrait"` restriction

### Task 2: Update Split Camera Preview
- [ ] 2.1 Detect current orientation using MediaQuery or OrientationBuilder
- [ ] 2.2 Use Row for portrait (vertical split)
- [ ] 2.3 Use Column for landscape (horizontal split)
- [ ] 2.4 Update divider to be horizontal or vertical based on orientation
- [ ] 2.5 Adjust label positions for each orientation

### Task 3: Update Camera Screen Layout
- [ ] 3.1 Ensure mode switcher works in landscape
- [ ] 3.2 Ensure capture button is accessible in landscape
- [ ] 3.3 Adjust overlay positions for landscape

### Task 4: Validation
- [ ] 4.1 Run `flutter analyze` — no errors
- [ ] 4.2 Run `flutter test` — all pass
- [ ] 4.3 Manual test: Portrait split view (left/right)
- [ ] 4.4 Manual test: Landscape split view (top/bottom)
- [ ] 4.5 Manual test: Rotation transition is smooth

---

## Technical Notes

```dart
Widget build(BuildContext context) {
  final isLandscape = MediaQuery.of(context).orientation == Orientation.landscape;
  
  if (isLandscape) {
    return Column(children: [normalPreview, divider, filteredPreview]);
  } else {
    return Row(children: [normalPreview, divider, filteredPreview]);
  }
}
```

---

## Dev Agent Record

### Agent Model Used
Claude Opus 4.5

### Completion Notes
- Enabled landscape orientations on iOS and Android
- Updated SplitCameraPreview to use Row (portrait) or Column (landscape)
- Updated CameraScreen to position controls appropriately in both orientations

### File List
| Action | File Path |
|--------|-----------|
| Modified | ios/Runner/Info.plist |
| Modified | android/app/src/main/AndroidManifest.xml |
| Modified | lib/widgets/split_camera_preview.dart |
| Modified | lib/screens/camera_screen.dart |

---

*Story complete*
