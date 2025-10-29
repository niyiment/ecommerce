import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

import '../constants/app_assets.dart';

class AppLocalizations {

  AppLocalizations(this.locale);
  final Locale locale;

  /// Get localized instance context
  static AppLocalizations of(BuildContext context) =>
      Localizations.of<AppLocalizations>(context, AppLocalizations)!;

  /// Localization delegate
  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  static const List<Locale> supportedLocales = <Locale>[
    Locale('en', ''), // English
    Locale('es', ''), // spanish
  ];

  late final Map<String, String> _localizedStrings;

  /// Load transitions from JSON file
  Future<void> load() async {
    try {
      final String jsonString = await rootBundle.loadString(
        '${AppAssets.translationsPath}${locale.languageCode}.json',
      );

      final Map<String, dynamic> jsonMap =
          json.decode(jsonString) as Map<String, dynamic>;

      _localizedStrings = jsonMap.map(
        (String key, dynamic value) =>
            MapEntry<String, String>(key, value.toString()),
      );
    } catch (e) {
      _localizedStrings = <String, String>{};
    }
  }

  /// Get translated string by key
  String translate(String key) => _localizedStrings[key] ?? key;

  // Common Translations
  String get appName => translate('app_name');

  String get appDescription => translate('app_description');

  // Splash Screen
  String get splashLoading => translate('splash_loading');

  String get splashWelcome => translate('splash_Welcome');

  // Onboarding Screen
  String get onboardingTitle1 => translate('onboarding_title_1');

  String get onboardingDescription1 => translate('onboarding_description_1');

  String get onboardingTitle2 => translate('onboarding_title_2');

  String get onboardingDescription2 => translate('onboarding_description_2');

  String get onboardingTitle3 => translate('onboarding_title_3');

  String get onboardingDescription3 => translate('onboarding_description_3');

  String get onboardingNext => translate('onboarding_next');

  String get onboardingSkip => translate('onboarding_skip');

  String get onboardingGetStarted => translate('onboarding_get_started');

  // Home Screen
  String get homeTitle => translate('home_title');

  String get homeWelcome => translate('home_welcome');

  String get homeDescription => translate('home_description');

  // Settings Screen
  String get settingsTitle => translate('settings_title');

  String get settingsTheme => translate('settings_theme');

  String get settingsThemeLight => translate('settings_theme_light');

  String get settingsThemeDark => translate('settings_theme_dark');

  String get settingsThemeSystem => translate('settings_theme_system');

  String get settingsLanguage => translate('settings_language');

  String get settingsAbout => translate('settings_about');

  String get settingsVersion => translate('settings_version');

  String get settingsResetOnboarding => translate('settings_reset_onboarding');

  String get settingsResetOnboardingDescription =>
      translate('settings_reset_onboarding_description');

  // Common Actions
  String get actionSave => translate('action_save');

  String get actionCancel => translate('action_cancel');

  String get actionOk => translate('action_ok');

  String get actionYes => translate('action_yes');

  String get actionNo => translate('action_no');

  String get actionDelete => translate('action_delete');

  String get actionEdit => translate('action_edit');

  String get actionClose => translate('action_close');

  String get actionBack => translate('action_back');

  String get actionNext => translate('action_next');

  String get actionDone => translate('action_done');

  String get actionRetry => translate('action_retry');

  // Common Messages
  String get messageSuccess => translate('message_success');

  String get messageError => translate('message_error');

  String get messageLoading => translate('message_loading');

  String get messageNoData => translate('message_no_data');

  String get messageNoInternet => translate('message_no_internet');
}

/// Localization delegate
class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => AppLocalizations.supportedLocales
      .map((Locale l) => l.languageCode)
      .contains(locale.languageCode);

  @override
  Future<AppLocalizations> load(Locale locale) async {
    final AppLocalizations localizations = AppLocalizations(locale);
    await localizations.load();
    return localizations;
  }

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

/// Extension for easy access to localizations
extension LocalizationExtension on BuildContext {
  AppLocalizations get l10n => AppLocalizations.of(this);
}
