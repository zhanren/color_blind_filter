# Story 4.1: Visible Header Bar

**Epic:** Epic 4 – UI Refinements  
**Priority:** High  
**Points:** 1

## Description

Add a visible, solid header bar at the top of the camera screen. Currently the controls (view toggle, camera flip, animal icon) float over the camera with only a gradient. Users need a clear, visible header that separates controls from the camera content.

## Problem

From user testing screenshot:
- Controls appear to float without clear separation
- No distinct header background visible
- Mode label in split view overlaps with camera content

## Acceptance Criteria

- [x] Header bar has a solid/semi-transparent dark background
- [x] Header is clearly distinguishable from camera preview
- [x] All controls remain accessible and properly positioned
- [x] Header respects safe area (notch, status bar)
- [x] Works in both portrait and landscape orientations

## Technical Implementation

### Files Modified

| File | Change |
|------|--------|
| `lib/widgets/camera_header.dart` | Replaced gradient with solid semi-transparent background |

### Design Specs

- Background: `Colors.black.withAlpha(200)` (78% opacity)
- Border: Subtle white bottom border (`Colors.white.withAlpha(30)`)
- Height: Auto-fit content + padding
- Safe area: Respects top safe area insets

## Status: ✅ COMPLETE

**Completed:** January 4, 2026
