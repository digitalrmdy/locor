import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:localization_builder/annotations.dart';
import 'messages_all.dart';
part 'app_localizations.g.dart';

@GenerateAppLocalizationsConfig(
    name: 'AppLocalizations',
    yamlStringsPath: 'lib/src/l10n/strings.yaml',
    supportedLocals: ['en', 'nl'],
    separatorStyle: SeparatorStyle.Underscore)
class AppLocalizationsConfig {}
