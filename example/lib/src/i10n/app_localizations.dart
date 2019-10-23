import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:localization_annotation/localization_annotation.dart';
import 'messages_all.dart';
part 'app_localizations.g.dart';

@GenerateAppLocalizationsConfig(name: 'AppLocalizations', yamlStringsPath: 'lib/resources/i18n/strings.yaml', supportedLocals: ['en','nl'])
class AppLocalizationsConfig {}