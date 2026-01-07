# Story 2.1: Animal Info Overlay

**Epic:** 2 — Educational Features & Photo Capture  
**Status:** Ready for Development  
**Priority:** P0 — Core differentiating feature  
**Estimate:** 2-3 hours  
**Depends On:** Story 1.4 (Mode Switcher)

---

## Story

**As a** user,  
**I want** to see which animals have vision similar to the current colorblind mode,  
**so that** I can understand color blindness through the relatable lens of animal perception.

---

## Acceptance Criteria

- [ ] AC1: Each filter mode displays a small animal icon in the corner of the camera view
- [ ] AC2: Animal icons are: Dog (Protanopia), Mouse (Deuteranopia), Whale (Tritanopia), Owl (Achromatopsia)
- [ ] AC3: Tapping the animal icon opens a bottom sheet with expanded information
- [ ] AC4: Bottom sheet includes: larger animal illustration, animal name, "Did you know?" fact
- [ ] AC5: Fun facts are accurate and kid-friendly
- [ ] AC6: Bottom sheet can be dismissed by tapping outside or swiping down
- [ ] AC7: Animal icon and info update immediately when user switches filter modes
- [ ] AC8: Animal icons are cute, simplified silhouettes matching playful brand aesthetic

---

## Dev Notes

### Architecture Reference
- See `docs/architecture.md` Section 4 (Component Standards)
- See `docs/architecture.md` Section 9 (Theming/Styling) for bottom sheet specs

### Animal Data (Embedded Constants)
```dart
// All animal data is embedded in code - no backend needed
const animalData = {
  FilterMode.protanopia: AnimalInfo(
    name: 'Dog',
    icon: 'assets/icons/dog.svg',
    fact: "Dogs can't see red, but they see blue and yellow really well! That's why some dog toys are blue.",
  ),
  FilterMode.deuteranopia: AnimalInfo(
    name: 'Mouse',
    icon: 'assets/icons/mouse.svg',
    fact: "Mice see mostly blues and yellows. Their world is like a sunset painting!",
  ),
  FilterMode.tritanopia: AnimalInfo(
    name: 'Whale',
    icon: 'assets/icons/whale.svg',
    fact: "Whales can only see blue light! The deep ocean looks like one big blue world to them.",
  ),
  FilterMode.achromatopsia: AnimalInfo(
    name: 'Owl',
    icon: 'assets/icons/owl.svg',
    fact: "Some owls see in black and white. They don't need color to hunt at night!",
  ),
};
```

### Icon Approach
- Use simple emoji or unicode characters for MVP (🐕 🐭 🐋 🦉)
- Future: Replace with custom SVG silhouettes

---

## Tasks

### Task 1: Create Animal Info Model
- [ ] 1.1 Create `lib/models/animal_info.dart`
- [ ] 1.2 Define `AnimalInfo` class with name, emoji, and fact
- [ ] 1.3 Add static map linking `FilterMode` to `AnimalInfo`

### Task 2: Add Extension to FilterMode
- [ ] 2.1 Add `animalInfo` getter to `FilterModeExtension`
- [ ] 2.2 Return corresponding `AnimalInfo` for each mode

### Task 3: Create Animal Icon Button Widget
- [ ] 3.1 Create `lib/widgets/animal_icon_button.dart`
- [ ] 3.2 Display circular button with animal emoji
- [ ] 3.3 Position in top-right corner of camera view
- [ ] 3.4 Ensure 44pt minimum touch target
- [ ] 3.5 Add subtle background for visibility over camera

### Task 4: Create Animal Info Bottom Sheet
- [ ] 4.1 Create `lib/widgets/animal_info_sheet.dart`
- [ ] 4.2 Display large emoji at top
- [ ] 4.3 Display animal name as title
- [ ] 4.4 Display "Did you know?" header and fact text
- [ ] 4.5 Style with app theme colors
- [ ] 4.6 Ensure dismissible by swipe down and outside tap

### Task 5: Integrate into Camera Screen
- [ ] 5.1 Add `AnimalIconButton` to camera screen stack
- [ ] 5.2 Implement `_showAnimalInfo()` method to open sheet
- [ ] 5.3 Pass current filter's animal info to components
- [ ] 5.4 Verify icon updates when filter mode changes

### Task 6: Write Tests
- [ ] 6.1 Unit test: AnimalInfo model structure
- [ ] 6.2 Unit test: FilterMode.animalInfo returns correct data
- [ ] 6.3 Widget test: AnimalIconButton renders emoji
- [ ] 6.4 Widget test: Tapping button triggers callback
- [ ] 6.5 Widget test: AnimalInfoSheet displays all content

### Task 7: Validation
- [ ] 7.1 Run `flutter analyze` — no errors
- [ ] 7.2 Run `flutter test` — all pass
- [ ] 7.3 Manual test: Icon visible on camera screen
- [ ] 7.4 Manual test: Tap opens bottom sheet
- [ ] 7.5 Manual test: Sheet content matches current filter
- [ ] 7.6 Manual test: Icon updates when switching modes
- [ ] 7.7 Manual test: Sheet dismisses correctly

---

## Testing Requirements

### Unit Tests
- AnimalInfo model properties
- FilterMode to AnimalInfo mapping

### Widget Tests
- AnimalIconButton renders and responds to taps
- AnimalInfoSheet displays name, emoji, and fact

### Manual Tests (Real Device)
- Icon is visible over camera preview
- Bottom sheet opens smoothly
- Content is readable and kid-friendly
- Updates when switching filter modes

---

## Animal Facts Reference

| Filter | Animal | Fun Fact |
|--------|--------|----------|
| Protanopia | Dog 🐕 | "Dogs can't see red, but they see blue and yellow really well! That's why some dog toys are blue." |
| Deuteranopia | Mouse 🐭 | "Mice see mostly blues and yellows. Their world is like a sunset painting!" |
| Tritanopia | Whale 🐋 | "Whales can only see blue light! The deep ocean looks like one big blue world to them." |
| Achromatopsia | Owl 🦉 | "Some owls see in black and white. They don't need color to hunt at night!" |

---

## Dev Agent Record

### Agent Model Used
Claude Opus 4.5

### Debug Log References
- Fixed const constructor warnings in widget tests

### Completion Notes
All 7 tasks completed successfully:
1. ✅ Created `AnimalInfo` model with name, emoji, and fact
2. ✅ Added `animalInfo` getter to `FilterModeExtension`
3. ✅ Created `AnimalIconButton` widget with circular design
4. ✅ Created `AnimalInfoSheet` bottom sheet with all content
5. ✅ Integrated animal button into camera screen
6. ✅ Unit tests (10 new) + Widget tests (8 new) all passing
7. ✅ Validation: `flutter analyze` clean, `flutter test` 52/52 passing

### File List
| Action | File Path |
|--------|-----------|
| Created | lib/models/animal_info.dart |
| Modified | lib/models/filter_mode.dart |
| Created | lib/widgets/animal_icon_button.dart |
| Created | lib/widgets/animal_info_sheet.dart |
| Modified | lib/screens/camera_screen.dart |
| Created | test/unit/animal_info_test.dart |
| Created | test/widget/animal_widgets_test.dart |

### Change Log
| Date | Change | Author |
|------|--------|--------|
| 2026-01-03 | Story 2.1 implemented | Dev Agent |

---

*Story ready for development*
