import 'package:flutter/material.dart';

import '../l10n/app_localizations.dart';
import '../theme/app_colors.dart';
import '../utils/color_matrices.dart';
import 'animal_info.dart';

/// The four colorblind simulation modes.
enum FilterMode {
  protanopia,
  deuteranopia,
  tritanopia,
  achromatopsia,
}

/// Extension providing metadata and utilities for each filter mode.
extension FilterModeExtension on FilterMode {
  /// Full display name for the filter mode (English fallback).
  String get displayName {
    switch (this) {
      case FilterMode.protanopia:
        return 'Protanopia';
      case FilterMode.deuteranopia:
        return 'Deuteranopia';
      case FilterMode.tritanopia:
        return 'Tritanopia';
      case FilterMode.achromatopsia:
        return 'Achromatopsia';
    }
  }

  /// Localized display name for the filter mode.
  String localizedDisplayName(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    switch (this) {
      case FilterMode.protanopia:
        return l10n.protanopia;
      case FilterMode.deuteranopia:
        return l10n.deuteranopia;
      case FilterMode.tritanopia:
        return l10n.tritanopia;
      case FilterMode.achromatopsia:
        return l10n.achromatopsia;
    }
  }

  /// Short description of the color blindness type (English fallback).
  String get shortName {
    switch (this) {
      case FilterMode.protanopia:
        return 'Red-blind';
      case FilterMode.deuteranopia:
        return 'Green-blind';
      case FilterMode.tritanopia:
        return 'Blue-blind';
      case FilterMode.achromatopsia:
        return 'Monochrome';
    }
  }

  /// Localized short description of the color blindness type.
  String localizedShortName(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    switch (this) {
      case FilterMode.protanopia:
        return l10n.redBlind;
      case FilterMode.deuteranopia:
        return l10n.greenBlind;
      case FilterMode.tritanopia:
        return l10n.blueBlind;
      case FilterMode.achromatopsia:
        return l10n.monochrome;
    }
  }

  /// The 5x4 color matrix for this filter mode.
  List<double> get colorMatrix {
    switch (this) {
      case FilterMode.protanopia:
        return ColorMatrices.protanopia;
      case FilterMode.deuteranopia:
        return ColorMatrices.deuteranopia;
      case FilterMode.tritanopia:
        return ColorMatrices.tritanopia;
      case FilterMode.achromatopsia:
        return ColorMatrices.achromatopsia;
    }
  }

  /// Button color for this filter mode (distinct in colorblind simulation).
  Color get buttonColor {
    switch (this) {
      case FilterMode.protanopia:
        return AppColors.filterProtanopia;
      case FilterMode.deuteranopia:
        return AppColors.filterDeuteranopia;
      case FilterMode.tritanopia:
        return AppColors.filterTritanopia;
      case FilterMode.achromatopsia:
        return AppColors.filterAchromatopsia;
    }
  }

  /// Animal with similar vision to this colorblind type (English fallback).
  AnimalInfo get animalInfo {
    switch (this) {
      case FilterMode.protanopia:
        return AnimalData.dog;
      case FilterMode.deuteranopia:
        return AnimalData.mouse;
      case FilterMode.tritanopia:
        return AnimalData.whale;
      case FilterMode.achromatopsia:
        return AnimalData.owl;
    }
  }

  /// Localized animal info with translated name and fact.
  AnimalInfo localizedAnimalInfo(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    switch (this) {
      case FilterMode.protanopia:
        return AnimalData.dog.localized(name: l10n.dog, fact: l10n.dogFact);
      case FilterMode.deuteranopia:
        return AnimalData.mouse.localized(name: l10n.mouse, fact: l10n.mouseFact);
      case FilterMode.tritanopia:
        return AnimalData.whale.localized(name: l10n.whale, fact: l10n.whaleFact);
      case FilterMode.achromatopsia:
        return AnimalData.owl.localized(name: l10n.owl, fact: l10n.owlFact);
    }
  }
}
