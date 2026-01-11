import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/app_settings.dart';

/// Service for persisting and loading app settings.
class SettingsService {
  static const String _localeKey = 'locale';

  /// Load settings from persistent storage.
  static Future<AppSettings> load() async {
    final prefs = await SharedPreferences.getInstance();
    
    final localeCode = prefs.getString(_localeKey) ?? 'en';
    
    return AppSettings(
      locale: Locale(localeCode),
    );
  }

  /// Save settings to persistent storage.
  static Future<void> save(AppSettings settings) async {
    final prefs = await SharedPreferences.getInstance();
    
    await prefs.setString(_localeKey, settings.locale.languageCode);
  }

  /// Update just the locale setting.
  static Future<void> setLocale(Locale locale) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_localeKey, locale.languageCode);
  }

  /// Get the current locale setting.
  static Future<Locale> getLocale() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final localeCode = prefs.getString(_localeKey) ?? 'en';
      return Locale(localeCode);
    } catch (e) {
      // Return default locale if SharedPreferences fails
      return const Locale('en');
    }
  }

}
