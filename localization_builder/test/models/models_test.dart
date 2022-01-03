import 'package:flutter_test/flutter_test.dart';
import 'package:localization_annotation/localization_annotation.dart';
import 'package:localization_builder/src/models/models.dart';
import 'package:localization_builder/src/stringsmetadatabuilder/strings_builder.dart';
import 'package:yaml/yaml.dart';

void main() {
  group('StringValue', () {
    group('generateMethodName', () {
      late StringValue testAppMethod;
      setUp(() {
        final testMap = {
          "common": {"appName": "TestApp"}
        };
        final yaml = YamlMap.wrap(testMap);
        final strings = StringsBuilder().buildFromYaml(yaml);
        testAppMethod = strings.findSomeValue();
      });

      test('${SeparatorStyle.CamelCase}', () {
        expect(testAppMethod.generateMethodName(SeparatorStyle.CamelCase), "commonAppName");
      });

      test('${SeparatorStyle.Underscore}', () {
        expect(testAppMethod.generateMethodName(SeparatorStyle.Underscore), "common_appName");
      });
    });
  });
}

extension on Strings {
  StringValue findSomeValue() {
    var children = this.children;
    for (var i = 0; i < children.length; i++) {
      var child = children[i];
      if (child is StringsContainer) {
        children = child.children;
        i = -1;
      } else if (child is StringValue) {
        return child;
      }
    }
    throw Exception();
  }
}
