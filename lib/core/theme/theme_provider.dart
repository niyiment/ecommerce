
import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constants/app_constants.dart';
import '../utils/logger.dart';

part 'theme_provider.g.dart';

// Provider for SharedPReferences
@Riverpod(keepAlive: true)
Future<SharedPreferences> sharedPreferences(SharedPreferencesProvider ref) async
  =>  SharedPreferences.getInstance();


// Provider for theme mode state
@Riverpod(keepAlive: true)
class ThemeModeState extends _$ThemeModeState {
  @override
  ThemeMode build() {
    _loadThemeMode();

    return ThemeMode.system;
  }

  Future<void> _loadThemeMode() async {
    try {
      final SharedPreferences prefs = await ref.read(sharedPreferencesProvider.future);
      final String? themeMode = prefs.getString(AppConstants.keyThemeMode);
      if (themeMode != null) {
        final ThemeMode loadedThemeMode = ThemeMode.values.firstWhere(
          (mode) => mode.toString() == themeMode,
          orElse: () => ThemeMode.system,
        );
        state = loadedThemeMode;
        AppLogger.info('Theme mode loaded: $loadedThemeMode');
      }
    } catch (e, stackTrace) {
      AppLogger.error('Error loading theme mode', error: e, stackTrace: stackTrace);
    }
  }

  /// Set and persis theme mode
  Future<void> setThemeMode(ThemeMode themeMode) async {
    try {
      final SharedPreferences prefs = await ref.read(sharedPreferencesProvider.future);
      await prefs.setString(AppConstants.keyThemeMode, themeMode.name);

      state = themeMode;
      AppLogger.info('Theme mode set: $themeMode');
    } catch (e, stackTrace) {
      AppLogger.error('Error setting theme mode', error: e,
          stackTrace: stackTrace);
    }
  }

  /// Toggle between light and dark theme
  Future<void> toggleTheme() async {
    final ThemeMode newThemeMode = state == ThemeMode.light
        ? ThemeMode.dark : ThemeMode.light;

    await setThemeMode(newThemeMode);
  }

  /// Check if current theme is dark
  bool get isDark => state == ThemeMode.dark;
  bool get isLight => state == ThemeMode.light;
  bool get isSystem => state == ThemeMode.system;
}


