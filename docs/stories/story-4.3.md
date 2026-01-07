# Story 4.3: Settings Screen with Language Selection

**Epic:** Epic 4 – UI Refinements  
**Priority:** Medium  
**Points:** 3

## Description

Add a settings button to the camera screen that opens a settings page. Initial setting is language selection (English, Chinese, Spanish). Architecture should support adding more settings in the future.

## Acceptance Criteria

- [x] Settings button (gear icon) appears in header
- [x] Tapping settings opens a settings screen/page
- [x] Language selection with 3 options: English, Chinese, Spanish
- [x] Selected language persists across app restarts
- [x] UI text updates to reflect selected language
- [x] Settings screen is extensible for future settings

## Technical Implementation

### New Files

| File | Purpose |
|------|---------|
| `lib/screens/settings_screen.dart` | Settings page UI |
| `lib/models/app_settings.dart` | Settings data model |
| `lib/utils/settings_service.dart` | Persist settings (SharedPreferences) |
| `lib/l10n/` | Localization files for each language |
| `lib/widgets/settings_button.dart` | Settings icon button |

### Dependencies to Add

```yaml
dependencies:
  shared_preferences: ^2.2.2
  flutter_localizations:
    sdk: flutter
```

### Supported Languages

| Code | Language |
|------|----------|
| `en` | English (default) |
| `zh` | Chinese (中文) |
| `es` | Spanish (Español) |

### Strings to Localize

- Filter mode names (Protanopia, Deuteranopia, etc.)
- Button labels (Capture, Save, Retake)
- Animal names and facts
- Permission screen text
- Settings screen labels

### Architecture

```
AppSettings
├── locale: Locale
└── (future settings here)

SettingsService
├── load() → AppSettings
├── save(AppSettings)
└── setLocale(Locale)
```

### Navigation

- Settings button in header → push to `/settings`
- Settings screen has back button to return

## Future Extensibility

Settings screen should use a list-based layout to easily add:
- Theme (light/dark/system)
- Resolution preference
- Default filter mode
- About/version info

## Status: ✅ COMPLETE

**Completed:** January 4, 2026
