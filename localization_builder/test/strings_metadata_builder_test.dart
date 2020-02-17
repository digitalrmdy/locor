import 'package:flutter_test/flutter_test.dart';
import 'package:localization_builder/src/stringsmetadatabuilder/strings_builder.dart';
import 'package:yaml/yaml.dart';

import 'utils/resource_reader.dart';

void main() {
  test("test if yaml is converted correctly", () {
    final resource = readResource("strings.yaml");
    final yaml = loadYaml(resource);
    final strings = StringsBuilder().buildFromYaml(yaml);
    print(strings);
    //TODO proper testing
  });
}
