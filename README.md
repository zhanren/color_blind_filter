# Color Blind Filter

See the world through colorblind and animal eyes. A Flutter mobile app that applies real-time camera filters to simulate how colorblind individuals (and animals) perceive the world.

## Features (MVP)

- 🎥 Real-time camera preview with colorblind filters
- 🔄 4 filter modes: Protanopia, Deuteranopia, Tritanopia, Achromatopsia
- 🐕 Animal info for each filter (dogs, mice, whales, owls)
- 📸 Photo capture and gallery save
- 🔀 Side-by-side comparison view

## Getting Started

### Prerequisites

- Flutter SDK 3.24.x or higher
- Dart SDK 3.5.x or higher
- Xcode (for iOS development)
- Android Studio (for Android development)

### Setup

1. Clone the repository:
   ```bash
   git clone <repository-url>
   cd color_blind_filter
   ```

2. Install dependencies:
   ```bash
   flutter pub get
   ```

3. Run the app:
   ```bash
   flutter run
   ```

### Platform Requirements

- **iOS:** 12.0+
- **Android:** API 21+ (Android 5.0 Lollipop)

## Project Structure

```
lib/
├── main.dart           # App entry point
├── app.dart            # MaterialApp configuration
├── screens/            # Full-page screens
├── widgets/            # Reusable UI components
├── models/             # Data models
├── utils/              # Utilities and constants
└── theme/              # Theming (colors, spacing, theme)
```

## Testing

```bash
# Run all tests
flutter test

# Run with coverage
flutter test --coverage

# Analyze code
flutter analyze
```

## Documentation

- [PRD](docs/prd.md) - Product Requirements Document
- [Architecture](docs/architecture.md) - Technical Architecture

## License

MIT
