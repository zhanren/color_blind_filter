# Color Blind Filter — Product Requirements Document (PRD)

**Version:** 0.1  
**Last Updated:** January 3, 2026  
**Author:** PM John

---

## 1. Goals and Background Context

### 1.1 Goals

- **Enable users to see the world through colorblind and animal eyes** via real-time camera filters
- **Educate users about color blindness types** (Protanopia, Deuteranopia, Tritanopia, Achromatopsia)
- **Create a fun, kid-friendly learning experience** connecting animal vision to human color blindness
- **Provide cross-platform mobile app** (iOS + Android) using Flutter
- **Learn camera API interactions** as a developer learning goal

### 1.2 Background Context

Color blindness affects approximately 8% of men and 0.5% of women globally, yet most people don't understand what colorblind individuals actually see. This app addresses that gap through an educational, playful approach rather than professional accessibility tooling.

The unique hook is the "animal vision" angle — connecting colorblind types to how animals like dogs, cats, and owls perceive the world. This makes the topic approachable for curious kids and pet owners ("See like my dog 🐕"). The technical implementation is surprisingly simple: color blindness simulation is matrix math, and Flutter's `ColorFiltered` widget provides GPU-accelerated filtering out of the box.

### 1.3 Change Log

| Date | Version | Description | Author |
|------|---------|-------------|--------|
| Jan 3, 2026 | 0.1 | Initial PRD draft from brainstorming session | PM John |

---

## 2. Requirements

### 2.1 Functional Requirements

| ID | Requirement |
|----|-------------|
| FR1 | The app shall display a real-time camera preview with GPU-accelerated color filter applied |
| FR2 | The app shall provide 4 colorblind simulation modes: Protanopia (red-blind), Deuteranopia (green-blind), Tritanopia (blue-blind), and Achromatopsia (monochromacy) |
| FR3 | The app shall display a mode switcher UI (button row) allowing users to toggle between filter modes |
| FR4 | The app shall show animal icons and educational info for each filter mode (e.g., "Dogs see like this") |
| FR5 | The app shall provide a side-by-side comparison view showing normal vision vs. filtered view simultaneously |
| FR6 | The app shall allow users to capture photos with the current filter applied |
| FR7 | The app shall save captured photos to the device's photo gallery |
| FR8 | The app shall request and handle camera permissions appropriately for iOS and Android |
| FR9 | The app shall request storage/gallery permissions before saving photos |

### 2.2 Non-Functional Requirements

| ID | Requirement |
|----|-------------|
| NFR1 | The camera preview shall maintain minimum 30 FPS with filter applied on mid-range devices (2020+) |
| NFR2 | Filter switching shall complete within 100ms to feel instantaneous |
| NFR3 | The app shall support iOS 12+ and Android API 21+ (Android 5.0+) |
| NFR4 | The UI shall be kid-friendly with clear, large touch targets (minimum 44pt) |
| NFR5 | The app shall work offline — no network connectivity required for core functionality |
| NFR6 | Photo capture and save shall complete within 2 seconds |
| NFR7 | The app binary size shall remain under 50MB to minimize download friction |

---

## 3. User Interface Design Goals

### 3.1 Overall UX Vision

A **playful, distraction-free camera experience** that lets users instantly "see through different eyes." The interface should feel like a fun educational toy — approachable enough for a curious 8-year-old, yet informative enough for adults interested in animal vision. The camera viewfinder dominates the screen; controls are minimal and intuitive.

### 3.2 Key Interaction Paradigms

- **Single-tap mode switching:** One tap changes the filter — no menus, no confirmations
- **Always-on preview:** Camera feed is always visible; filters apply in real-time
- **Progressive disclosure:** Basic modes visible immediately; animal info appears on demand
- **Thumb-friendly controls:** All interactive elements reachable with one-handed use
- **Instant feedback:** Filter changes and captures provide immediate visual/haptic response

### 3.3 Core Screens and Views

| Screen | Purpose |
|--------|---------|
| **Camera View (Main)** | Full-screen camera preview with filter applied, mode switcher at bottom |
| **Side-by-Side View** | Split screen comparing normal vs. filtered vision |
| **Animal Info Overlay** | Modal or bottom sheet showing animal icon + fun facts for current mode |
| **Permission Request** | System dialogs + friendly explanation screens for camera/storage access |
| **Photo Review** | Brief preview after capture with save/retake options |

### 3.4 Accessibility

**Target: WCAG AA**

- Minimum contrast ratios for all text overlays on camera feed
- VoiceOver/TalkBack support for mode switching and capture
- Large touch targets (44pt minimum) per NFR4

### 3.5 Branding

- **Aesthetic:** Bright, cheerful, slightly playful — think "educational museum exhibit" not "medical tool"
- **Color palette:** Vibrant accent colors that remain distinguishable even through colorblind filters
- **Typography:** Rounded, friendly sans-serif (e.g., Nunito, Quicksand)
- **Iconography:** Cute, simplified animal silhouettes for each vision mode

### 3.6 Target Platforms

**Cross-Platform: iOS + Android**

- **Primary:** Smartphones in portrait orientation
- **Responsive:** Support various screen sizes (iPhone SE to iPad, Android phones)
- **Orientation:** Portrait-locked for MVP

---

## 4. Technical Assumptions

### 4.1 Repository Structure

**Monorepo** — Single repository containing the Flutter application.

```
color_blind_filter/
├── lib/                    # Dart source code
│   ├── main.dart
│   ├── screens/
│   ├── widgets/
│   ├── models/
│   └── utils/
├── assets/                 # Images, icons, fonts
├── ios/                    # iOS platform code
├── android/                # Android platform code
├── test/                   # Unit and widget tests
├── pubspec.yaml            # Dependencies
└── docs/                   # Documentation
```

### 4.2 Service Architecture

**Monolith (Single Mobile App)**

- No backend required — all processing happens on-device
- No API calls — color matrices are embedded in app
- No database — photos saved directly to device gallery
- Fully offline capable (aligns with NFR5)

### 4.3 Testing Requirements

| Test Level | Coverage Target | Purpose |
|------------|-----------------|---------|
| **Unit Tests** | Color matrix transformations, utility functions | Verify filter math is correct |
| **Widget Tests** | Mode switcher, capture button, UI components | Verify UI behavior |
| **Integration Tests** | Camera + filter pipeline (manual) | Verify real device performance |

### 4.4 Additional Technical Assumptions

**Framework & Language:**
- Flutter 3.x (latest stable) with Dart

**Key Packages:**

| Package | Purpose |
|---------|---------|
| `camera` | Live camera preview |
| `permission_handler` | Camera/storage permissions |
| `image_gallery_saver` | Save photos to gallery |

**State Management:**
- Riverpod or simple `setState` for MVP (minimal app state)

**Color Matrix Implementation:**
- Pre-computed 5x4 matrices embedded as constants
- Applied via Flutter's `ColorFiltered` widget with `ColorFilter.matrix()`

**Platform Targets:**
- iOS 12.0+
- Android API 21+ (Android 5.0 Lollipop)

**Build & Deployment:**
- Manual builds for MVP (no CI/CD required)
- Future: GitHub Actions for automated builds

---

## 5. Epic Overview

| Epic | Title | Goal |
|------|-------|------|
| 1 | Foundation & Live Filtered Camera | Establish project infrastructure and deliver core real-time colorblind simulation |
| 2 | Educational Features & Photo Capture | Add animal info, side-by-side view, and photo capture capabilities |

---

## 6. Epic 1: Foundation & Live Filtered Camera

**Goal:** Establish project infrastructure and deliver the core real-time colorblind simulation experience. Users can point their camera at the world and instantly see it through colorblind eyes, switching between 4 simulation modes.

### Story 1.1: Project Setup & Folder Structure

**As a** developer,  
**I want** a properly structured Flutter project with all dependencies configured,  
**so that** I can begin implementing camera features on a solid foundation.

**Acceptance Criteria:**

1. Flutter project created with app name "Color Blind Filter" and package identifier
2. Folder structure matches architecture spec: `lib/{screens,widgets,models,utils}`, `assets/`, `test/`
3. `pubspec.yaml` includes `camera`, `permission_handler` dependencies with pinned versions
4. App launches on both iOS Simulator and Android Emulator showing placeholder screen
5. iOS `Info.plist` contains `NSCameraUsageDescription` with user-friendly message
6. Android `AndroidManifest.xml` contains camera permission declaration
7. Basic `README.md` with setup instructions exists

---

### Story 1.2: Camera Permission Handling

**As a** user,  
**I want** the app to clearly request camera access with an explanation,  
**so that** I understand why the permission is needed and can grant it confidently.

**Acceptance Criteria:**

1. On first launch, app displays friendly explanation screen before system permission dialog
2. Explanation screen includes camera icon, clear text ("We need camera access to show you colorblind vision"), and "Continue" button
3. Tapping "Continue" triggers native iOS/Android permission dialog
4. If permission granted, app navigates to camera screen
5. If permission denied, app shows "Permission Required" screen with button to open device Settings
6. Permission state persists across app restarts (doesn't re-ask if already granted)
7. App handles "restricted" state gracefully (parental controls, enterprise policies)

---

### Story 1.3: Live Camera Preview with Protanopia Filter

**As a** user,  
**I want** to see a live camera feed with a colorblind filter applied in real-time,  
**so that** I can point my phone at anything and instantly see how it looks to someone with color blindness.

**Acceptance Criteria:**

1. Camera preview fills the screen in portrait orientation
2. Preview displays at minimum 30 FPS on test device
3. Protanopia color matrix filter is applied via `ColorFiltered` widget
4. Filter visibly transforms colors (red objects appear different)
5. Camera properly pauses when app goes to background
6. Camera properly resumes when app returns to foreground
7. "Protanopia" label displayed on screen indicating current mode
8. No visible lag between camera movement and filtered preview

---

### Story 1.4: Mode Switcher with All Four Filters

**As a** user,  
**I want** to switch between different colorblind simulation modes with a single tap,  
**so that** I can compare how Protanopia, Deuteranopia, Tritanopia, and Achromatopsia affect vision.

**Acceptance Criteria:**

1. Bottom of screen displays 4 mode buttons in a horizontal row
2. Buttons labeled: "Protanopia", "Deuteranopia", "Tritanopia", "Achromatopsia"
3. Current active mode button is visually highlighted (different color/border)
4. Tapping a mode button switches the filter within 100ms (feels instant)
5. Mode label on preview updates to match selected filter
6. All 4 color matrices produce visibly different results
7. Color matrices use scientifically-sourced values (documented in code comments)
8. Touch targets meet 44pt minimum size requirement
9. Selected mode persists if app is backgrounded and resumed

---

## 7. Epic 2: Educational Features & Photo Capture

**Goal:** Add the differentiating educational content and enable users to capture and save their discoveries. This epic transforms the app from "camera with filter" to "See like my dog" — the complete educational experience.

### Story 2.1: Animal Info Overlay

**As a** user,  
**I want** to see which animals have vision similar to the current colorblind mode,  
**so that** I can understand color blindness through the relatable lens of animal perception.

**Acceptance Criteria:**

1. Each filter mode displays a small animal icon in the corner of the camera view
2. Animal icons are: Dog (Protanopia), Mouse (Deuteranopia), Whale (Tritanopia), Owl (Achromatopsia)
3. Tapping the animal icon opens a bottom sheet with expanded information
4. Bottom sheet includes: larger animal illustration, animal name, "Did you know?" fact about their vision
5. Fun facts are accurate and kid-friendly (e.g., "Dogs can't see red, but they see blue and yellow really well!")
6. Bottom sheet can be dismissed by tapping outside or swiping down
7. Animal icon and info update immediately when user switches filter modes
8. Animal icons are cute, simplified silhouettes matching the playful brand aesthetic

---

### Story 2.2: Side-by-Side Comparison View

**As a** user,  
**I want** to see normal vision and colorblind vision simultaneously,  
**so that** I can directly compare and understand what colors are lost or changed.

**Acceptance Criteria:**

1. A toggle button allows switching between "Full Screen" and "Split View" modes
2. Split View divides screen vertically: left side shows normal camera, right side shows filtered
3. Both views update in real-time from the same camera feed
4. Labels indicate which side is "Normal" and which is the current filter name
5. Filter mode switcher remains functional in Split View (changes right side only)
6. Animal info icon remains accessible in Split View
7. Split View maintains minimum 24 FPS performance
8. Toggle state persists within session but resets to Full Screen on app restart
9. Divider line between views is subtle but visible

---

### Story 2.3: Photo Capture & Gallery Save

**As a** user,  
**I want** to capture the filtered camera view and save it to my photo gallery,  
**so that** I can keep and share what I've learned about colorblind vision.

**Acceptance Criteria:**

1. Capture button (camera icon) displayed prominently on the camera screen
2. Tapping capture button takes a photo with the current filter applied
3. Capture provides immediate feedback (shutter animation and/or haptic)
4. After capture, brief review screen shows the photo with "Save" and "Retake" options
5. If storage permission not yet granted, prompt user before first save attempt
6. Permission explanation: "Save photos to your gallery to share with friends"
7. "Save" stores the image to device photo gallery within 2 seconds
8. Success feedback shown (toast/snackbar: "Photo saved!")
9. "Retake" returns to live camera view without saving
10. In Split View mode, capture saves only the filtered half (not the comparison)
11. Saved image includes metadata: filter name, date (standard EXIF)

---

## 8. Technical Reference

### Color Matrices

```dart
// Protanopia (Red-blind) - Dogs, cats, cattle
const protanopia = [
  0.567, 0.433, 0.000, 0, 0,
  0.558, 0.442, 0.000, 0, 0,
  0.000, 0.242, 0.758, 0, 0,
  0, 0, 0, 1, 0,
];

// Deuteranopia (Green-blind) - Most mammals, mice, rats
const deuteranopia = [
  0.625, 0.375, 0.000, 0, 0,
  0.700, 0.300, 0.000, 0, 0,
  0.000, 0.300, 0.700, 0, 0,
  0, 0, 0, 1, 0,
];

// Tritanopia (Blue-blind) - Some whales
const tritanopia = [
  0.950, 0.050, 0.000, 0, 0,
  0.000, 0.433, 0.567, 0, 0,
  0.000, 0.475, 0.525, 0, 0,
  0, 0, 0, 1, 0,
];

// Achromatopsia (Monochromacy) - Owls, bats, raccoons
const achromatopsia = [
  0.299, 0.587, 0.114, 0, 0,
  0.299, 0.587, 0.114, 0, 0,
  0.299, 0.587, 0.114, 0, 0,
  0, 0, 0, 1, 0,
];
```

### Animal Vision Reference

| Filter Mode | Animals | Fun Fact |
|-------------|---------|----------|
| Protanopia | Dogs, cats, cattle, bulls | Dogs see blue and yellow well, but red looks brown to them |
| Deuteranopia | Most mammals, mice, rats | Mice rely more on smell than color vision |
| Tritanopia | Some whales | Rare in nature; whales adapted for deep ocean blue light |
| Achromatopsia | Owls, bats, raccoons | Nocturnal animals traded color for better night vision |

---

## 9. Out of Scope (Future Versions)

The following features were identified during brainstorming but deferred from MVP:

| Feature | Target Version | Notes |
|---------|----------------|-------|
| Share with animal caption | V1.1 | "Through my dog's eyes 🐕" overlay |
| Fun facts tooltips | V1.1 | "Did you know?" pop-ups |
| Intensity slider | V1.2 | Adjust filter strength 0-100% |
| UI themes (light/dark) | V2.0 | Kid-friendly theme option |
| Playful animations/sounds | V2.0 | Engagement features |
| Landscape orientation | V2.0 | Additional complexity |

---

*Document generated using BMAD-METHOD™ PRD workflow*
