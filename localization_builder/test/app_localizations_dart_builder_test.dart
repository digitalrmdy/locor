import 'package:flutter_test/flutter_test.dart';
import 'package:localization_builder/annotations.dart';
import 'package:localization_builder/src/dartbuilders/app_localizations_dart_builder.dart';
import 'package:localization_builder/src/stringsmetadatabuilder/strings_builder.dart';

import 'package:yaml/yaml.dart';

import 'utils/resource_reader.dart';

void main() {
  test("test if dart builder throws no exceptions", () {
    final resource = readResource("strings.yaml");
    final yaml = loadYaml(resource);
    final strings = StringsBuilder().buildFromYaml(yaml);
    final String name = "AppLocalizations";
    final List<String> locals = ['en', 'nl'];
    final SeparatorStyle separatorStyle = SeparatorStyle.CamelCase;
    final dartFile = AppLocalizationsDartBuilder()
        .buildDartFile(name, strings, locals, separatorStyle);
    print(dartFile);
  });
}
