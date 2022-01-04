import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:locor/locor.dart';
import 'messages_all.dart';
part 'app_localizations.g.dart';

@GenerateAppLocalizations(
    name: 'AppLocalizations',
    yamlStringsPath: 'lib/src/l10n/strings.yaml',
    supportedLocals: ['en', 'nl'],
    separatorStyle: SeparatorStyle.Underscore)
void main() {}
