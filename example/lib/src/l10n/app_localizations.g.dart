// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_localizations.dart';

// **************************************************************************
// AppLocalizationsGenerator
// **************************************************************************

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
  String get loginButtonLogin =>
      Intl.message('Login', name: 'loginButtonLogin');
  String get loginButtonContinueWithoutRegister =>
      Intl.message('Continue without registering',
          name: 'loginButtonContinueWithoutRegister');
  String get registerButton => Intl.message('Register', name: 'registerButton');
  String get registerErrorDialogMsg => Intl.message(
      'An error occured during the register call.\nPlease try again.',
      name: 'registerErrorDialogMsg');
  String get registerErrorDialogTitle =>
      Intl.message('Register Error!', name: 'registerErrorDialogTitle');
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
