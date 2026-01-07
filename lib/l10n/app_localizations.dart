import 'package:flutter/material.dart';

/// Application localizations with support for English, Chinese, and Spanish.
class AppLocalizations {
  AppLocalizations(this.locale);

  final Locale locale;

  static AppLocalizations of(BuildContext context) {
    final localizations = Localizations.of<AppLocalizations>(context, AppLocalizations);
    // Return English fallback if localizations not yet loaded
    return localizations ?? AppLocalizations(const Locale('en'));
  }

  /// Check if localizations are available in the context.
  static bool isAvailable(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations) != null;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  static const List<Locale> supportedLocales = [
    Locale('en'), // English
    Locale('zh'), // Chinese
    Locale('es'), // Spanish
  ];

  static const Map<String, String> _languageNames = {
    'en': 'English',
    'zh': '中文',
    'es': 'Español',
  };

  /// Get display name for a language code.
  static String getLanguageName(String code) => _languageNames[code] ?? code;

  // Strings map for each locale
  static final Map<String, Map<String, String>> _localizedStrings = {
    'en': {
      // App
      'appName': 'Color Blind Filter',
      
      // Filter modes
      'protanopia': 'Protanopia',
      'deuteranopia': 'Deuteranopia',
      'tritanopia': 'Tritanopia',
      'achromatopsia': 'Achromatopsia',
      'redBlind': 'Red-blind',
      'greenBlind': 'Green-blind',
      'blueBlind': 'Blue-blind',
      'monochrome': 'Monochrome',
      
      // View modes
      'normal': 'Normal',
      'fullScreen': 'Full Screen',
      'splitView': 'Split View',
      
      // Actions
      'capture': 'Capture',
      'save': 'Save',
      'retake': 'Retake',
      'saved': 'Photo saved to gallery',
      'saveFailed': 'Failed to save photo',
      'captureFailed': 'Failed to capture photo. Please try again.',
      
      // Permissions
      'welcomeTitle': 'See the World Differently',
      'welcomeSubtitle': 'Experience how animals and people with color blindness see the world',
      'enableCamera': 'Enable Camera',
      'cameraNeeded': 'Camera access is needed to show live color filters',
      'permissionDenied': 'Camera Permission Denied',
      'permissionDeniedDesc': 'To use the color blind filter, please enable camera access in your device settings.',
      'openSettings': 'Open Settings',
      
      // Animals
      'dog': 'Dog',
      'dogFact': 'Dogs see the world similar to humans with red-green color blindness. They can distinguish blue and yellow but red appears as brown or gray.',
      'mouse': 'Mouse',
      'mouseFact': 'Mice have dichromatic vision similar to green-blind humans. They see well in low light but have limited color perception.',
      'whale': 'Whale',
      'whaleFact': 'Most whales are blue-blind, adapted to the deep ocean where blue light dominates. They see the world in shades of green and yellow.',
      'owl': 'Owl',
      'owlFact': 'Owls have rod-dominated retinas optimized for night vision. In bright light, they see mostly in grayscale like humans with complete color blindness.',
      
      // Settings
      'settings': 'Settings',
      'language': 'Language',
      'selectLanguage': 'Select Language',
    },
    'zh': {
      // App
      'appName': '色盲滤镜',
      
      // Filter modes
      'protanopia': '红色盲',
      'deuteranopia': '绿色盲',
      'tritanopia': '蓝色盲',
      'achromatopsia': '全色盲',
      'redBlind': '红色盲',
      'greenBlind': '绿色盲',
      'blueBlind': '蓝色盲',
      'monochrome': '单色',
      
      // View modes
      'normal': '正常',
      'fullScreen': '全屏',
      'splitView': '分屏对比',
      
      // Actions
      'capture': '拍照',
      'save': '保存',
      'retake': '重拍',
      'saved': '照片已保存到相册',
      'saveFailed': '保存失败',
      'captureFailed': '拍照失败，请重试。',
      
      // Permissions
      'welcomeTitle': '用不同的视角看世界',
      'welcomeSubtitle': '体验动物和色盲人士眼中的世界',
      'enableCamera': '启用相机',
      'cameraNeeded': '需要相机权限来显示实时滤镜',
      'permissionDenied': '相机权限被拒绝',
      'permissionDeniedDesc': '要使用色盲滤镜，请在设备设置中启用相机权限。',
      'openSettings': '打开设置',
      
      // Animals
      'dog': '狗',
      'dogFact': '狗看世界的方式类似于红绿色盲的人类。它们能分辨蓝色和黄色，但红色看起来像棕色或灰色。',
      'mouse': '老鼠',
      'mouseFact': '老鼠拥有类似绿色盲人类的双色视觉。它们在弱光下看得很清楚，但颜色感知有限。',
      'whale': '鲸鱼',
      'whaleFact': '大多数鲸鱼是蓝色盲，适应了蓝光主导的深海环境。它们看到的世界是绿色和黄色的色调。',
      'owl': '猫头鹰',
      'owlFact': '猫头鹰的视网膜以视杆细胞为主，专为夜视优化。在强光下，它们看到的主要是灰度，类似于完全色盲的人类。',
      
      // Settings
      'settings': '设置',
      'language': '语言',
      'selectLanguage': '选择语言',
    },
    'es': {
      // App
      'appName': 'Filtro Daltonismo',
      
      // Filter modes
      'protanopia': 'Protanopía',
      'deuteranopia': 'Deuteranopía',
      'tritanopia': 'Tritanopía',
      'achromatopsia': 'Acromatopsia',
      'redBlind': 'Ceguera al rojo',
      'greenBlind': 'Ceguera al verde',
      'blueBlind': 'Ceguera al azul',
      'monochrome': 'Monocromático',
      
      // View modes
      'normal': 'Normal',
      'fullScreen': 'Pantalla completa',
      'splitView': 'Vista dividida',
      
      // Actions
      'capture': 'Capturar',
      'save': 'Guardar',
      'retake': 'Repetir',
      'saved': 'Foto guardada en la galería',
      'saveFailed': 'Error al guardar',
      'captureFailed': 'Error al capturar. Inténtalo de nuevo.',
      
      // Permissions
      'welcomeTitle': 'Ve el Mundo Diferente',
      'welcomeSubtitle': 'Experimenta cómo los animales y las personas con daltonismo ven el mundo',
      'enableCamera': 'Activar Cámara',
      'cameraNeeded': 'Se necesita acceso a la cámara para mostrar filtros en vivo',
      'permissionDenied': 'Permiso de Cámara Denegado',
      'permissionDeniedDesc': 'Para usar el filtro de daltonismo, active el acceso a la cámara en la configuración.',
      'openSettings': 'Abrir Configuración',
      
      // Animals
      'dog': 'Perro',
      'dogFact': 'Los perros ven el mundo de manera similar a los humanos con daltonismo rojo-verde. Pueden distinguir azul y amarillo, pero el rojo parece marrón o gris.',
      'mouse': 'Ratón',
      'mouseFact': 'Los ratones tienen visión dicromática similar a los humanos con ceguera al verde. Ven bien con poca luz pero tienen percepción limitada del color.',
      'whale': 'Ballena',
      'whaleFact': 'La mayoría de las ballenas son ciegas al azul, adaptadas al océano profundo donde domina la luz azul. Ven el mundo en tonos de verde y amarillo.',
      'owl': 'Búho',
      'owlFact': 'Los búhos tienen retinas dominadas por bastones optimizados para la visión nocturna. Con luz brillante, ven principalmente en escala de grises.',
      
      // Settings
      'settings': 'Configuración',
      'language': 'Idioma',
      'selectLanguage': 'Seleccionar idioma',
    },
  };

  String get(String key) {
    return _localizedStrings[locale.languageCode]?[key] ?? 
           _localizedStrings['en']?[key] ?? 
           key;
  }

  // Convenience getters for common strings
  String get appName => get('appName');
  String get protanopia => get('protanopia');
  String get deuteranopia => get('deuteranopia');
  String get tritanopia => get('tritanopia');
  String get achromatopsia => get('achromatopsia');
  String get redBlind => get('redBlind');
  String get greenBlind => get('greenBlind');
  String get blueBlind => get('blueBlind');
  String get monochrome => get('monochrome');
  String get normal => get('normal');
  String get fullScreen => get('fullScreen');
  String get splitView => get('splitView');
  String get capture => get('capture');
  String get save => get('save');
  String get retake => get('retake');
  String get saved => get('saved');
  String get saveFailed => get('saveFailed');
  String get captureFailed => get('captureFailed');
  String get welcomeTitle => get('welcomeTitle');
  String get welcomeSubtitle => get('welcomeSubtitle');
  String get enableCamera => get('enableCamera');
  String get cameraNeeded => get('cameraNeeded');
  String get permissionDenied => get('permissionDenied');
  String get permissionDeniedDesc => get('permissionDeniedDesc');
  String get openSettings => get('openSettings');
  String get settings => get('settings');
  String get language => get('language');
  String get selectLanguage => get('selectLanguage');
  
  // Animal getters
  String get dog => get('dog');
  String get dogFact => get('dogFact');
  String get mouse => get('mouse');
  String get mouseFact => get('mouseFact');
  String get whale => get('whale');
  String get whaleFact => get('whaleFact');
  String get owl => get('owl');
  String get owlFact => get('owlFact');
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    return ['en', 'zh', 'es'].contains(locale.languageCode);
  }

  @override
  Future<AppLocalizations> load(Locale locale) async {
    return AppLocalizations(locale);
  }

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}
