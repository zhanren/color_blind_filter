# Brainstorming Session Results

**Session Date:** January 1, 2026  
**Facilitator:** Business Analyst Mary  
**Participant:** User

---

## Executive Summary

**Topic:** Color Blind Filter Camera App — A mobile application that applies real-time camera filters to simulate how colorblind individuals (and animals) see the world.

**Session Goals:** 
- Explore features for an educational camera app
- Identify tech stack for cross-platform (iOS + Android)
- Learn camera API interactions

**Techniques Used:** 
1. First Principles Thinking (~15 min)
2. Mind Mapping (~10 min)
3. Role Playing (~5 min)

**Total Ideas Generated:** 15

**MVP Scope:** 6 features (Real-time preview, 4 filter modes, permissions, animal info, side-by-side view, photo capture)

### Key Themes Identified:
- Educational focus over practical/professional use
- Animal vision as unique hook ("See like my dog")
- Kid-friendly, playful experience
- Learning camera APIs as primary developer goal

---

## Technique Sessions

### First Principles Thinking — 15 min

**Description:** Breaking down the problem to fundamental truths and rebuilding understanding.

**Ideas Generated:**
1. Color blindness = cone deficiency causing color confusion (not total color loss)
2. Four main types: Protanopia, Deuteranopia, Tritanopia, Achromatopsia
3. Cross-platform framework needed: Flutter recommended
4. Real-time filtering requires efficient processing (GPU-accelerated)
5. ColorMatrix transformation — 3x3 matrix per filter type
6. Flutter's `ColorFiltered` widget + `camera` package = simple implementation

**Insights Discovered:**
- Color transformation is just matrix math — surprisingly simple
- Flutter provides GPU-accelerated color filtering out of the box
- ~20 lines of code to get live camera preview working

**Notable Connections:**
- Matrix math connects to accessibility testing tools
- Same technique used in photo editing apps

---

### Mind Mapping — 10 min

**Description:** Visual branching from central concept to map features and components.

**Ideas Generated:**
1. Permissions handling (iOS/Android differences)
2. Mode switch UI — button row
3. Live preview — full screen real-time filter
4. Photo capture + save to gallery
5. Side-by-side comparison view
6. Animal info per colorblind type
7. Intensity slider (filter strength)
8. UI themes

**Insights Discovered:**
- Five main branches: Permissions, Mode Switch, Live Preview, Capture, Settings
- Animal education is a differentiator

**Notable Connections:**
- Side-by-side view useful for both education and sharing

---

### Role Playing — 5 min

**Description:** Exploring the app from different user perspectives.

**Ideas Generated:**
1. Pet owner persona: "What does my dog see?"
2. Curious kid persona: "Woah, dogs can't see red?!"
3. "See like my dog" as featured mode
4. Share photo with animal caption
5. Fun facts / "Did you know?" tips
6. Playful, kid-friendly UI

**Insights Discovered:**
- Primary users: Pet owners, curious kids, casual learners
- NOT targeting professional designers (educational focus)

**Notable Connections:**
- Pet owner + kid personas both value shareability and fun facts

---

## Idea Categorization

### Immediate Opportunities
*Ideas ready to implement now (MVP)*

1. **Real-time camera preview with filter**
   - Description: Live camera feed with ColorMatrix filter applied
   - Why immediate: Core feature, primary learning goal
   - Resources needed: Flutter, camera package, ColorFiltered widget

2. **4 colorblind mode buttons**
   - Description: Protanopia, Deuteranopia, Tritanopia, Achromatopsia
   - Why immediate: Essential functionality
   - Resources needed: Pre-computed color matrices

3. **Camera permissions handling**
   - Description: Request and manage camera access on iOS/Android
   - Why immediate: Required for camera to work
   - Resources needed: Flutter permission_handler package

4. **Animal icon + info per mode**
   - Description: Show which animals see similarly (dog, cat, etc.)
   - Why immediate: Unique educational hook
   - Resources needed: Animal icons, fact text

5. **Side-by-side comparison view**
   - Description: Split screen showing normal vs filtered view
   - Why immediate: Key educational feature for understanding the difference
   - Resources needed: Dual camera stream or image processing

6. **Photo capture + save to gallery**
   - Description: Capture filtered image and save locally
   - Why immediate: Enables sharing and preserving discoveries
   - Resources needed: Image capture, gallery permissions

### Future Innovations
*Ideas requiring development/research (V1.1+)*

1. **Share with animal caption**
   - Description: Export image with "Through my dog's eyes 🐕" caption
   - Development needed: Share intent, image overlay
   - Timeline estimate: V1.1

2. **Fun facts tooltips**
   - Description: "Did you know?" pop-ups with animal vision facts
   - Development needed: Tooltip UI, fact database
   - Timeline estimate: V1.1

3. **Intensity slider**
   - Description: Adjust filter strength from 0-100%
   - Development needed: Matrix interpolation
   - Timeline estimate: V1.2

### Moonshots
*Ambitious, transformative concepts*

1. **UI themes**
   - Description: Light/dark mode, kid-friendly theme
   - Transformative potential: Broader audience appeal
   - Challenges to overcome: Design effort

2. **Playful animations/sounds**
   - Description: Fun feedback for kid engagement
   - Transformative potential: Viral/shareable moments
   - Challenges to overcome: May annoy adult users

### Insights & Learnings
*Key realizations from the session*

- Color blindness simulation is matrix math: Surprisingly approachable technically
- Flutter is ideal for this project: Cross-platform, GPU-accelerated filters, great docs
- Animal angle is the differentiator: "See like my dog" is the hook
- Educational > Professional: Focus on fun and learning, not accessibility tools
- Shareability matters: Users will want to show others what they learned

---

## Action Planning

### Top 5 Priority Ideas (MVP)

#### #1 Priority: Real-time Camera Preview with Filter
- Rationale: Core learning goal — understanding camera API interaction
- Next steps: 
  1. Create Flutter project
  2. Add camera package
  3. Implement basic camera preview
  4. Apply ColorFiltered widget with test matrix
- Resources needed: Flutter SDK, physical device for testing
- Timeline: 1-2 days

#### #2 Priority: Mode Switcher with 4 Filters
- Rationale: Demonstrates ColorMatrix transforms, core functionality
- Next steps:
  1. Create color matrices for all 4 types
  2. Build button row UI
  3. Wire button taps to filter changes
- Resources needed: Colorblind simulation matrices (available online)
- Timeline: 1 day

#### #3 Priority: Animal Info per Mode
- Rationale: Unique educational hook, differentiates from other filter apps
- Next steps:
  1. Research which animals have each vision type
  2. Find/create animal icons
  3. Add info display below mode buttons
- Resources needed: Animal icons, research sources
- Timeline: 0.5 days

#### #4 Priority: Side-by-Side Comparison View
- Rationale: Key educational feature — see the difference immediately
- Next steps:
  1. Implement split-screen layout
  2. Show normal view on one side, filtered on other
  3. Add toggle to switch between full-screen and split mode
- Resources needed: Layout design, potentially two camera streams or image copy
- Timeline: 1-2 days

#### #5 Priority: Photo Capture + Save to Gallery
- Rationale: Enables sharing discoveries, adds utility beyond live preview
- Next steps:
  1. Add capture button UI
  2. Implement image capture from filtered view
  3. Request storage permissions
  4. Save to device gallery
- Resources needed: image_gallery_saver package, storage permissions
- Timeline: 1 day

---

## Reflection & Follow-up

### What Worked Well
- First Principles Thinking clarified the technical approach quickly
- Mind Mapping structured the feature space effectively
- Role Playing narrowed the target audience focus

### Areas for Further Exploration
- Exact color matrices: Need to find scientifically accurate matrices
- Animal vision research: Verify which animals have which type
- Flutter camera performance: Test on older devices

### Recommended Follow-up Techniques
- SCAMPER: Could generate more creative features when ready for V2
- User Testing: Show prototype to kids and pet owners

### Questions That Emerged
- How accurate are color blindness simulations?
- Can we show "what the dog sees" vs "what you see" simultaneously?
- Would AR features (identify objects by color) be valuable?

### Next Session Planning
- **Suggested topics:** Technical architecture, UI/UX design
- **Recommended timeframe:** After MVP prototype is working
- **Preparation needed:** Working camera preview

---

## Technical Reference

### Recommended Tech Stack

| Component | Technology | Purpose |
|-----------|------------|---------|
| Framework | Flutter | Cross-platform iOS/Android |
| Camera | `camera` package | Live camera preview |
| Filters | `ColorFiltered` widget | GPU-accelerated color matrix |
| Permissions | `permission_handler` | Camera access |
| State | `setState` or `Riverpod` | Mode switching |

### Color Matrices (Starting Point)

```dart
// Protanopia (Red-blind)
const protanopia = [
  0.567, 0.433, 0.000, 0, 0,
  0.558, 0.442, 0.000, 0, 0,
  0.000, 0.242, 0.758, 0, 0,
  0, 0, 0, 1, 0,
];

// Deuteranopia (Green-blind)  
const deuteranopia = [
  0.625, 0.375, 0.000, 0, 0,
  0.700, 0.300, 0.000, 0, 0,
  0.000, 0.300, 0.700, 0, 0,
  0, 0, 0, 1, 0,
];

// Tritanopia (Blue-blind)
const tritanopia = [
  0.950, 0.050, 0.000, 0, 0,
  0.000, 0.433, 0.567, 0, 0,
  0.000, 0.475, 0.525, 0, 0,
  0, 0, 0, 1, 0,
];

// Achromatopsia (Monochromacy)
const achromatopsia = [
  0.299, 0.587, 0.114, 0, 0,
  0.299, 0.587, 0.114, 0, 0,
  0.299, 0.587, 0.114, 0, 0,
  0, 0, 0, 1, 0,
];
```

### Animal Vision Reference

| Filter Mode | Animals |
|-------------|---------|
| Protanopia | Dogs, cats, cattle, bulls |
| Deuteranopia | Most mammals, mice, rats |
| Tritanopia | Some whales (rare in nature) |
| Achromatopsia | Owls, bats, raccoons (nocturnal) |

---

*Session facilitated using the BMAD-METHOD™ brainstorming framework*
