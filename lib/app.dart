import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'l10n/app_localizations.dart';
import 'screens/camera_screen.dart';
import 'screens/permission_screen.dart';
import 'screens/review_screen.dart';
import 'screens/settings_screen.dart';
import 'screens/splash_screen.dart';
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
  bool _showSplash = false;

  @override
  void initState() {
    super.initState();
    _initializeApp();
  }

  Future<void> _initializeApp() async {
    try {
      // Load locale
      final locale = await SettingsService.getLocale();
      
      if (mounted) {
        setState(() {
          _locale = locale;
          _showSplash = true; // Always show splash screen
          _isLoading = false;
        });
      }
    } catch (e) {
      debugPrint('Error initializing app: $e');
      // Fallback to English if loading fails
      if (mounted) {
        setState(() {
          _locale = const Locale('en');
          _showSplash = true; // Always show splash screen
          _isLoading = false;
        });
      }
    }
  }

  Future<void> _onSplashComplete() async {
    // Navigate away from splash screen
    if (mounted) {
      setState(() {
        _showSplash = false;
      });
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
      home: _isLoading
          ? _buildLoadingScreen()
          : _showSplash
              ? SplashScreen(onComplete: _onSplashComplete)
              : const PermissionScreen(),
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
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Image.asset(
          'assets/icons/dog.png',
          width: 80,
          height: 80,
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
