# Story 5.2: Swipe to Hide/Show UI Controls

**Epic:** Epic 5 – UX Improvements  
**Priority:** Medium  
**Points:** 3

## Description

Allow users to hide both the top header bar AND the bottom mode switcher by swiping, providing a fully immersive filming experience. Show them again with the opposite swipe or a tap.

## Acceptance Criteria

- [x] Swipe down hides BOTH header bar and mode switcher
- [x] Swipe up shows BOTH header bar and mode switcher
- [x] Tap on screen when hidden shows controls
- [x] Smooth animation when hiding/showing
- [x] Capture button remains visible when controls are hidden
- [x] Small visual indicator when controls are hidden
- [ ] Auto-hide after 3 seconds of inactivity (optional - deferred)

## Technical Implementation

### Files to Modify

| File | Change |
|------|--------|
| `lib/screens/camera_screen.dart` | Add gesture detection, animate both bars |

### UI States

**Controls Visible (Default):**
```
┌─────────────────────────────┐
│ [⬜][📷] Protanopia [🐕][⚙️]│  ← Header bar
├─────────────────────────────┤
│                             │
│      Camera Preview         │
│                             │
│                     [📷]    │  ← Capture button (always visible)
│                             │
│ [Proto][Deut][Trit][Achro]  │  ← Mode switcher
└─────────────────────────────┘
```

**Controls Hidden (Immersive Mode):**
```
┌─────────────────────────────┐
│                             │
│                             │
│      Camera Preview         │
│         (full screen)       │
│                     [📷]    │  ← Capture button stays
│                             │
│         ─────────           │  ← Small handle indicator
└─────────────────────────────┘
```

### Gesture Behavior

| Gesture | Current State | Action |
|---------|---------------|--------|
| Swipe down | Controls visible | Hide all controls |
| Swipe up | Controls hidden | Show all controls |
| Swipe up | Controls visible | No action |
| Swipe down | Controls hidden | No action |
| Tap anywhere | Controls hidden | Show all controls |

### Animation

- Use `AnimatedSlide` or `AnimatedPositioned` for smooth transitions
- Header slides up (off top of screen)
- Mode switcher slides down (off bottom of screen)
- Duration: 250ms
- Curve: `Curves.easeInOut`

### State Management

```dart
bool _controlsVisible = true;

void _toggleControls() {
  setState(() => _controlsVisible = !_controlsVisible);
}

void _showControls() {
  if (!_controlsVisible) {
    setState(() => _controlsVisible = true);
  }
}

void _hideControls() {
  if (_controlsVisible) {
    setState(() => _controlsVisible = false);
  }
}
```

## Status: ✅ COMPLETE

**Completed:** January 4, 2026
