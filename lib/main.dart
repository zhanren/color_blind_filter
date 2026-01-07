import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Allow Google Fonts to fail gracefully (use system fonts as fallback)
  GoogleFonts.config.allowRuntimeFetching = true;
  
  // Set up error handling for uncaught errors
  FlutterError.onError = (details) {
    FlutterError.presentError(details);
  };
  
  runApp(const ColorBlindFilterApp());
}
