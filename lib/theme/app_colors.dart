import 'package:flutter/material.dart';

/// App color palette.
///
/// Colors chosen to remain distinguishable through colorblind filters.
abstract class AppColors {
  AppColors._();

  // ============ Primary Palette ============

  /// Primary brand color - vibrant teal
  static const Color primary = Color(0xFF00B4A0);
  static const Color onPrimary = Color(0xFFFFFFFF);

  /// Secondary accent - warm amber
  static const Color secondary = Color(0xFFFFB74D);
  static const Color onSecondary = Color(0xFF1A1A1A);

  // ============ Neutral Palette ============

  static const Color surface = Color(0xFFF8F9FA);
  static const Color onSurface = Color(0xFF1A1A1A);
  static const Color surfaceVariant = Color(0xFFE8EAED);

  // ============ Semantic Colors ============

  static const Color error = Color(0xFFE53935);
  static const Color success = Color(0xFF43A047);

  // ============ Filter Mode Colors ============

  /// Protanopia button - Blue (visible to protanopes)
  static const Color filterProtanopia = Color(0xFF2196F3);

  /// Deuteranopia button - Purple (visible to deuteranopes)
  static const Color filterDeuteranopia = Color(0xFF9C27B0);

  /// Tritanopia button - Orange (visible to tritanopes)
  static const Color filterTritanopia = Color(0xFFFF9800);

  /// Achromatopsia button - High contrast gray
  static const Color filterAchromatopsia = Color(0xFF616161);

  // ============ Overlay Colors ============

  /// Semi-transparent black for text over camera
  static const Color cameraOverlay = Color(0x99000000);

  /// Badge/pill background
  static const Color badge = Color(0xE6FFFFFF);
}
