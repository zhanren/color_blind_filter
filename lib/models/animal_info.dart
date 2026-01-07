/// Information about an animal with similar vision to a colorblind mode.
class AnimalInfo {
  const AnimalInfo({
    required this.name,
    required this.emoji,
    required this.fact,
  });

  /// The animal's name (e.g., "Dog").
  final String name;

  /// Emoji representation of the animal.
  final String emoji;

  /// Kid-friendly fact about the animal's vision.
  final String fact;

  /// Create a localized copy with translated name and fact.
  AnimalInfo localized({required String name, required String fact}) {
    return AnimalInfo(
      name: name,
      emoji: emoji,
      fact: fact,
    );
  }
}

/// Embedded animal data for each colorblind type.
/// All data is stored as constants - no backend needed.
abstract class AnimalData {
  AnimalData._();

  static const AnimalInfo dog = AnimalInfo(
    name: 'Dog',
    emoji: '🐕',
    fact:
        "Dogs can't see red, but they see blue and yellow really well! That's why some dog toys are blue.",
  );

  static const AnimalInfo mouse = AnimalInfo(
    name: 'Mouse',
    emoji: '🐭',
    fact:
        'Mice see mostly blues and yellows. Their world is like a sunset painting!',
  );

  static const AnimalInfo whale = AnimalInfo(
    name: 'Whale',
    emoji: '🐋',
    fact:
        'Whales can only see blue light! The deep ocean looks like one big blue world to them.',
  );

  static const AnimalInfo owl = AnimalInfo(
    name: 'Owl',
    emoji: '🦉',
    fact:
        "Some owls see in black and white. They don't need color to hunt at night!",
  );
}
