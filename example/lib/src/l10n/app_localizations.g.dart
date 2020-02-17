// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_localizations.dart';

// **************************************************************************
// AppLocalizationsGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names
class AppLocalizations {
  static Future<AppLocalizations> load(Locale locale) {
    final String name = locale.countryCode == null || locale.countryCode.isEmpty
        ? locale.languageCode
        : locale.toString();
    String localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      return AppLocalizations();
    });
  }

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  String get appTitle => Intl.message('Sample', name: 'appTitle');
  String welcome(firstName) =>
      Intl.message('Welcome, $firstName', name: 'welcome', args: [firstName]);
  String get login_button_login =>
      Intl.message('Login', name: 'login_button_login');
  String get login_button_continueWithoutRegister =>
      Intl.message('Continue without registering',
          name: 'login_button_continueWithoutRegister');
  String get register_button =>
      Intl.message('Register', name: 'register_button');
  String get register_error_dialog_msg => Intl.message(
      'An error occured during the register call.\nPlease try again.',
      name: 'register_error_dialog_msg');
  String get register_error_dialog_title =>
      Intl.message('Register Error!', name: 'register_error_dialog_title');
}

class AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    return ['en', 'nl'].contains(locale.languageCode);
  }

  @override
  Future<AppLocalizations> load(Locale locale) {
    return AppLocalizations.load(locale);
  }

  @override
  bool shouldReload(LocalizationsDelegate<AppLocalizations> old) {
    return false;
  }
}
