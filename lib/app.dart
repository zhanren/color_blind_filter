import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'l10n/app_localizations.dart';
import 'screens/camera_screen.dart';
import 'screens/permission_screen.dart';
import 'screens/review_screen.dart';
import 'screens/settings_screen.dart';
import 'theme/app_theme.dart';
import 'utils/settings_service.dart';

/// Root widget for the Color Blind Filter app.
class ColorBlindFilterApp extends StatefulWidget {
  const ColorBlindFilterApp({super.key});

  @override
  State<ColorBlindFilterApp> createState() => _ColorBlindFilterAppState();
}

class _ColorBlindFilterAppState extends State<ColorBlindFilterApp> {
  Locale _locale = const Locale('en');
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadLocale();
  }

  Future<void> _loadLocale() async {
    try {
      final locale = await SettingsService.getLocale();
      if (mounted) {
        setState(() {
          _locale = locale;
          _isLoading = false;
        });
      }
    } catch (e) {
      // Fallback to English if loading fails
      if (mounted) {
        setState(() {
          _locale = const Locale('en');
          _isLoading = false;
        });
      }
    }
  }

  void _setLocale(Locale locale) {
    setState(() => _locale = locale);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Color Blind Filter',
      theme: AppTheme.light,
      debugShowCheckedModeBanner: false,
      locale: _locale,
      supportedLocales: AppLocalizations.supportedLocales,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      home: _isLoading ? _buildLoadingScreen() : const PermissionScreen(),
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case '/':
            return MaterialPageRoute(
              builder: (_) => const PermissionScreen(),
            );
          case '/camera':
            return MaterialPageRoute(
              builder: (_) => CameraScreen(onLocaleChanged: _setLocale),
            );
          case '/review':
            return MaterialPageRoute(
              settings: settings,
              builder: (_) => const ReviewScreen(),
            );
          case '/settings':
            return MaterialPageRoute(
              builder: (_) => const SettingsScreen(),
            );
          default:
            return MaterialPageRoute(
              builder: (_) => const PermissionScreen(),
            );
        }
      },
    );
  }

  Widget _buildLoadingScreen() {
    return const Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: CircularProgressIndicator(
          color: Colors.white,
        ),
      ),
    );
  }
}
