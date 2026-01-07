import 'package:flutter/material.dart';

/// Application settings data model.
class AppSettings {
  const AppSettings({
    this.locale = const Locale('en'),
  });

  /// The selected language locale.
  final Locale locale;

  /// Create a copy with updated values.
  AppSettings copyWith({
    Locale? locale,
  }) {
    return AppSettings(
      locale: locale ?? this.locale,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AppSettings &&
          runtimeType == other.runtimeType &&
          locale == other.locale;

  @override
  int get hashCode => locale.hashCode;
}
