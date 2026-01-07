# Story 1.2: Camera Permission Handling

**Epic:** 1 — Foundation & Live Filtered Camera  
**Status:** Ready for Review  
**Priority:** P0 — Blocks camera functionality  
**Estimate:** 2-3 hours  
**Depends On:** Story 1.1 (Project Setup)

---

## Story

**As a** user,  
**I want** the app to clearly request camera access with an explanation,  
**so that** I understand why the permission is needed and can grant it confidently.

---

## Acceptance Criteria

- [ ] AC1: On first launch, app displays friendly explanation screen before system permission dialog
- [ ] AC2: Explanation screen includes camera icon, clear text ("We need camera access to show you colorblind vision"), and "Continue" button
- [ ] AC3: Tapping "Continue" triggers native iOS/Android permission dialog
- [ ] AC4: If permission granted, app navigates to camera screen (placeholder for now)
- [ ] AC5: If permission denied, app shows "Permission Required" screen with button to open device Settings
- [ ] AC6: Permission state persists across app restarts (doesn't re-ask if already granted)
- [ ] AC7: App handles "restricted" state gracefully (parental controls, enterprise policies)

---

## Dev Notes

### Architecture Reference
- See `docs/architecture.md` Section 6.2 (Permission Service)
- See `docs/architecture.md` Section 7 (Routing)

### Technical Details
- Use `permission_handler` package (already in pubspec.yaml)
- Create `PermissionService` utility class
- Create `PermissionScreen` as the new initial route
- Navigation: Permission → Camera (placeholder)

### Key Patterns
```dart
// Permission check
final status = await Permission.camera.status;
if (status.isGranted) { /* navigate */ }

// Request permission
final result = await Permission.camera.request();

// Open settings
await openAppSettings();
```

---

## Tasks

### Task 1: Create Permission Service
- [x] 1.1 Create `lib/utils/permissions.dart`
- [x] 1.2 Implement `PermissionResult` enum (granted, denied, permanentlyDenied, restricted)
- [x] 1.3 Implement `PermissionService.requestCamera()` method
- [x] 1.4 Implement `PermissionService.openSettings()` method
- [x] 1.5 Write unit tests for permission result mapping

### Task 2: Create Permission Screen UI
- [x] 2.1 Create `lib/screens/permission_screen.dart`
- [x] 2.2 Implement welcome UI with camera icon and explanation text
- [x] 2.3 Add "Continue" button with 44pt minimum touch target
- [x] 2.4 Style according to app theme (AppColors, AppSpacing)

### Task 3: Create Permission Denied Screen
- [x] 3.1 Create denied state UI within permission screen (or separate widget)
- [x] 3.2 Show message explaining permission is required
- [x] 3.3 Add "Open Settings" button
- [x] 3.4 Add "Try Again" button for re-requesting

### Task 4: Create Camera Placeholder Screen
- [x] 4.1 Create `lib/screens/camera_screen.dart` (placeholder)
- [x] 4.2 Show simple message: "Camera permission granted! Camera coming in Story 1.3"
- [x] 4.3 This will be replaced in Story 1.3

### Task 5: Implement Navigation Flow
- [x] 5.1 Update `lib/app.dart` with route definitions
- [x] 5.2 Set PermissionScreen as initial route
- [x] 5.3 Implement navigation from Permission → Camera on grant
- [x] 5.4 Create `lib/utils/navigation.dart` helper (skipped - not needed)

### Task 6: Implement Permission Logic
- [x] 6.1 Check permission on PermissionScreen init
- [x] 6.2 If already granted, navigate directly to camera
- [x] 6.3 If not granted, show explanation UI
- [x] 6.4 On "Continue" tap, request permission
- [x] 6.5 Handle all permission results appropriately

### Task 7: Write Tests
- [x] 7.1 Unit test: PermissionService methods
- [x] 7.2 Widget test: PermissionScreen renders correctly
- [x] 7.3 Widget test: CameraScreen placeholder renders correctly
- [x] 7.4 Widget test: App launches correctly

### Task 8: Validation
- [x] 8.1 Run `flutter analyze` — no errors ✅
- [x] 8.2 Run `flutter test` — 9 tests pass ✅
- [ ] 8.3 Manual test: Fresh install shows permission screen
- [ ] 8.4 Manual test: Grant permission → navigates to camera
- [ ] 8.5 Manual test: Deny permission → shows denied UI
- [ ] 8.6 Manual test: App restart with granted permission → skips to camera

---

## Testing Requirements

### Unit Tests
- `PermissionService.requestCamera()` returns correct `PermissionResult` for each status

### Widget Tests
- PermissionScreen displays explanation text and button
- PermissionScreen denied state displays settings button
- Button callbacks are invoked correctly

### Manual Tests (Real Device Required)
- Full permission flow on iOS
- Full permission flow on Android
- Settings redirect works correctly

---

## Dev Agent Record

### Agent Model Used
Claude (James - Dev Agent)

### Debug Log References
- No issues encountered during implementation

### Completion Notes
- PermissionService created with full permission flow handling
- PermissionScreen handles welcome state, denied state, and permanently denied state
- CameraScreen placeholder ready for Story 1.3 replacement
- Navigation flow: PermissionScreen → CameraScreen on permission grant
- Auto-skip to camera if permission already granted on app restart
- 9 tests passing (4 unit, 5 widget)

### File List
| Action | File Path |
|--------|-----------|
| Created | `lib/utils/permissions.dart` |
| Created | `lib/screens/permission_screen.dart` |
| Created | `lib/screens/camera_screen.dart` |
| Modified | `lib/app.dart` |
| Deleted | `lib/screens/placeholder_screen.dart` |
| Created | `test/unit/permissions_test.dart` |
| Created | `test/widget/permission_screen_test.dart` |
| Created | `test/widget/camera_screen_test.dart` |
| Modified | `test/widget_test.dart` |

### Change Log
| Date | Change | Author |
|------|--------|--------|
| Jan 3, 2026 | Story 1.2 implemented - Permission handling complete | James (Dev Agent) |

---

*Story ready for development*
