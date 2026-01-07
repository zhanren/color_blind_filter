# Story 4.2: Landscape Split View - Left/Right Layout

**Epic:** Epic 4 – UI Refinements  
**Priority:** High  
**Points:** 1

## Description

Change the landscape split view orientation from top/bottom to left/right (horizontal comparison). This matches user expectations for comparing views side-by-side when the phone is held horizontally.

## Problem

From user testing:
- Current landscape split view shows Normal on top, Filtered on bottom
- User expects left/right comparison in landscape mode
- Portrait mode (left/right) and landscape mode (should also be left/right)

## Acceptance Criteria

- [x] Landscape split view shows Normal on LEFT, Filtered on RIGHT
- [x] Portrait split view remains LEFT/RIGHT (unchanged)
- [x] Labels remain visible and properly positioned in both orientations
- [x] Capture button position works well with new layout

## Technical Implementation

### Files Modified

| File | Change |
|------|--------|
| `lib/widgets/split_camera_preview.dart` | Simplified to always use Row (left/right) |

### Layout Summary

| Orientation | Layout | Left | Right |
|-------------|--------|------|-------|
| Portrait | Row | Normal | Filtered |
| Landscape | Row | Normal | Filtered |

### Code Change

Removed orientation check - now always uses Row layout:

```dart
// Always left/right layout (both portrait and landscape)
return Row(
  children: [
    Expanded(child: normalPane),
    Container(width: 2, color: dividerColor),
    Expanded(child: filteredPane),
  ],
);
```

## Status: ✅ COMPLETE

**Completed:** January 4, 2026
