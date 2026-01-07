# Story 3.3: Add App Header Bar

**Epic:** 3 — Polish & Enhancements  
**Status:** Ready for Development  
**Priority:** P0 — UI overlap issue  
**Estimate:** 1-2 hours  
**Depends On:** Story 1.4

---

## Story

**As a** user,  
**I want** the app to have a proper header area,  
**so that** important UI elements don't get covered by the phone's native status bar.

---

## Problem

Current implementation doesn't have an app bar. UI elements at the top (view toggle, animal icon, mode label) overlap with the phone's native status bar (time, battery, signal icons), making them hard to read and tap.

---

## Acceptance Criteria

- [ ] AC1: App has a semi-transparent header bar at the top
- [ ] AC2: Header properly respects safe area (notch, status bar)
- [ ] AC3: Mode label is displayed in the header
- [ ] AC4: View toggle button is in the header (left side)
- [ ] AC5: Animal info button is in the header (right side)
- [ ] AC6: Header doesn't obstruct camera preview significantly
- [ ] AC7: Header works in both portrait and landscape

---

## Tasks

### Task 1: Create App Header Widget
- [ ] 1.1 Create `lib/widgets/camera_header.dart`
- [ ] 1.2 Use SafeArea to respect system UI
- [ ] 1.3 Semi-transparent background for visibility over camera
- [ ] 1.4 Include view toggle button (left)
- [ ] 1.5 Include mode label (center)
- [ ] 1.6 Include animal info button (right)

### Task 2: Update Camera Screen
- [ ] 2.1 Remove individually positioned top buttons
- [ ] 2.2 Add CameraHeader widget to Stack
- [ ] 2.3 Position header at top with SafeArea

### Task 3: Style Header
- [ ] 3.1 Semi-transparent dark background
- [ ] 3.2 Proper padding and spacing
- [ ] 3.3 Text/icons readable over any camera content

### Task 4: Validation
- [ ] 4.1 Run `flutter analyze` — no errors
- [ ] 4.2 Run `flutter test` — all pass
- [ ] 4.3 Manual test: Header visible and functional
- [ ] 4.4 Manual test: No overlap with status bar
- [ ] 4.5 Manual test: Works on notched and non-notched devices

---

## Design Reference

```
┌─────────────────────────────────────┐
│ [Status Bar - Phone's native UI]    │
├─────────────────────────────────────┤
│ [⊞]   Deuteranopia 🐭   [🐭]        │  ← App Header (semi-transparent)
├─────────────────────────────────────┤
│                                     │
│         Camera Preview              │
│                                     │
│              [📷]                   │
│                                     │
├─────────────────────────────────────┤
│ [Protanopia] [Deuteranopia] [...]   │  ← Mode Switcher
└─────────────────────────────────────┘
```

---

## Dev Agent Record

### Agent Model Used
Claude Opus 4.5

### Completion Notes
- Created `CameraHeader` widget with gradient background and SafeArea
- Header contains view toggle (left), mode label (center), animal button (right)
- Replaced individually positioned top buttons with unified header
- Header properly respects safe area on all devices (notch, status bar)

### File List
| Action | File Path |
|--------|-----------|
| Created | lib/widgets/camera_header.dart |
| Modified | lib/screens/camera_screen.dart |

---

*Story complete*
