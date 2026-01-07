import 'package:flutter/material.dart';

import '../l10n/app_localizations.dart';
import '../theme/app_colors.dart';
import '../theme/app_spacing.dart';
import '../utils/settings_service.dart';

/// Settings screen with language selection.
class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  Locale _currentLocale = const Locale('en');

  @override
  void initState() {
    super.initState();
    _loadCurrentLocale();
  }

  Future<void> _loadCurrentLocale() async {
    final locale = await SettingsService.getLocale();
    if (mounted) {
      setState(() => _currentLocale = locale);
    }
  }

  Future<void> _onLanguageSelected(Locale locale) async {
    await SettingsService.setLocale(locale);
    if (mounted) {
      setState(() => _currentLocale = locale);
      // Pop back and signal that locale changed
      Navigator.of(context).pop(locale);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        title: Text(l10n.settings),
        elevation: 0,
      ),
      body: ListView(
        children: [
          // Language section
          _buildSectionHeader(l10n.language),
          ...AppLocalizations.supportedLocales.map((locale) {
            final isSelected = locale.languageCode == _currentLocale.languageCode;
            return _buildLanguageOption(
              locale: locale,
              isSelected: isSelected,
              onTap: () => _onLanguageSelected(locale),
            );
          }),
          
          const SizedBox(height: AppSpacing.xl),
          
          // Future settings can be added here
          // Example sections:
          // _buildSectionHeader('Display'),
          // _buildSectionHeader('About'),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.md,
        AppSpacing.lg,
        AppSpacing.md,
        AppSpacing.sm,
      ),
      child: Text(
        title,
        style: const TextStyle(
          color: AppColors.primary,
          fontSize: 14,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.5,
        ),
      ),
    );
  }

  Widget _buildLanguageOption({
    required Locale locale,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    final languageName = AppLocalizations.getLanguageName(locale.languageCode);
    
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.md,
            vertical: AppSpacing.md,
          ),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: Colors.white.withAlpha(20),
                width: 1,
              ),
            ),
          ),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  languageName,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                  ),
                ),
              ),
              if (isSelected)
                const Icon(
                  Icons.check,
                  color: AppColors.primary,
                  size: 24,
                ),
            ],
          ),
        ),
      ),
    );
  }
}
