import 'dart:ui';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import 'core/theme/app_theme.dart';
import 'features/splash/presentation/pages/splash_screen.dart';
import 'generated/locale_keys.g.dart';
import 'service_locator.dart';

void main() async {
  // Initialize Flutter bindings
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize easy_localization
  await EasyLocalization.ensureInitialized();

  // Setup dependency injection
  setupServiceLocator();

  // Get device locale
  final deviceLocale = _getDeviceLocale();

  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('en'), Locale('ar')],
      path: 'assets/translations',
      fallbackLocale: const Locale('en'),
      startLocale: deviceLocale,
      child: const MyApp(),
    ),
  );
}

/// Get device locale or fallback to English
Locale _getDeviceLocale() {
  try {
    Locale deviceLocale = PlatformDispatcher.instance.locale;

    // Check if device language is supported
    if (deviceLocale.languageCode == 'ar') {
      return const Locale('ar');
    } else if (deviceLocale.languageCode == 'en') {
      return const Locale('en');
    }
    // Default to English if language not supported
    return const Locale('en');
  } catch (e) {
    // Fallback to English if anythin g goes wrong
    return const Locale('en');
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: LocaleKeys.appTitle.tr(),
      debugShowCheckedModeBanner: false,
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      theme: AppTheme.getLightTheme(),
      darkTheme: AppTheme.getDarkTheme(),
      themeMode: ThemeMode.light,
      home: SplashScreen(),
    );
  }
}

/// Wrapper widget that handles Firebase initialization
