/// Scientifically-sourced color matrices for colorblind simulation.
///
/// Each matrix is a 5x4 (20 element) array used with [ColorFilter.matrix()].
/// Format: [R, G, B, A, offset] for each of R, G, B, A output channels.
///
/// Sources:
/// - Machado et al. (2009) - "A Physiologically-based Model for Simulation
///   of Color Vision Deficiency"
/// - https://www.inf.ufrgs.br/~oliveira/pubs_files/CVD_Simulation/CVD_Simulation.html
abstract class ColorMatrices {
  ColorMatrices._(); // Prevent instantiation

  /// Protanopia (Red-blind) - Affects ~1% of males.
  ///
  /// Animals with similar vision: Dogs, cats, cattle, bulls.
  /// Red appears as brown/dark; difficulty distinguishing red from green.
  static const List<double> protanopia = [
    0.567, 0.433, 0.000, 0, 0, // R output
    0.558, 0.442, 0.000, 0, 0, // G output
    0.000, 0.242, 0.758, 0, 0, // B output
    0, 0, 0, 1, 0, // A output (unchanged)
  ];

  /// Deuteranopia (Green-blind) - Affects ~1% of males.
  ///
  /// Animals with similar vision: Most mammals, mice, rats.
  /// Green appears differently; difficulty distinguishing red from green.
  static const List<double> deuteranopia = [
    0.625, 0.375, 0.000, 0, 0,
    0.700, 0.300, 0.000, 0, 0,
    0.000, 0.300, 0.700, 0, 0,
    0, 0, 0, 1, 0,
  ];

  /// Tritanopia (Blue-blind) - Affects ~0.01% of population.
  ///
  /// Animals with similar vision: Some whales (rare in nature).
  /// Blue appears greenish; difficulty distinguishing blue from yellow.
  static const List<double> tritanopia = [
    0.950, 0.050, 0.000, 0, 0,
    0.000, 0.433, 0.567, 0, 0,
    0.000, 0.475, 0.525, 0, 0,
    0, 0, 0, 1, 0,
  ];

  /// Achromatopsia (Complete color blindness / Monochromacy).
  ///
  /// Animals with similar vision: Owls, bats, raccoons (nocturnal animals).
  /// No color perception; sees only in grayscale.
  /// Uses standard luminance weights (ITU-R BT.601).
  static const List<double> achromatopsia = [
    0.299, 0.587, 0.114, 0, 0,
    0.299, 0.587, 0.114, 0, 0,
    0.299, 0.587, 0.114, 0, 0,
    0, 0, 0, 1, 0,
  ];

  /// Identity matrix (no transformation) - for normal vision in split view.
  static const List<double> identity = [
    1, 0, 0, 0, 0,
    0, 1, 0, 0, 0,
    0, 0, 1, 0, 0,
    0, 0, 0, 1, 0,
  ];
}
