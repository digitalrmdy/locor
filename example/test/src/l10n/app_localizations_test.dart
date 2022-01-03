import 'dart:ui';

import 'package:flutter_test/flutter_test.dart';

import '../../../lib/src/l10n/app_localizations.dart';

void main() {
  test("test if translation for 'nl' locale is correct", () async {
    final local = Locale.fromSubtags(languageCode: 'nl');

    final appLocalizations = await AppLocalizations.load(local);
    expect(appLocalizations.appTitle, equals("Voorbeeld"));
  });

  test("test if translation for 'en' locale is correct", () async {
    final local = Locale.fromSubtags(languageCode: 'en');

    final appLocalizations = await AppLocalizations.load(local);
    expect(appLocalizations.appTitle, equals("Example"));
  });

  test("test translation with argument", () async {
    final local = Locale.fromSubtags(languageCode: 'nl');

    final appLocalizations = await AppLocalizations.load(local);

    expect(appLocalizations.welcome("Ruben"), equals("Welkom, Ruben"));
  });
}
