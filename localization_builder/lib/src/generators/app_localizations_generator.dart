import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:glob/glob.dart';
import 'package:localization_annotation/localization_annotation.dart';


import 'package:source_gen/source_gen.dart';
import 'package:yaml/yaml.dart';


import '../dartbuilders/app_localizations_dart_builder.dart';
import '../exceptions/exceptions.dart';
import '../stringsmetadatabuilder/strings_builder.dart';

class AppLocalizationsGenerator
    extends GeneratorForAnnotation<GenerateAppLocalizationsConfig> {
  const AppLocalizationsGenerator();

  Future<YamlMap> _toYamlMap(String path, BuildStep buildStep) async {
    List<AssetId> results = await buildStep.findAssets(Glob(path)).toList();
    final size = results.length;
    if (size == 0) {
      throw AppLocalizationsGeneratorException(
          "path: '$path' could not be found");
    } else if (size > 1) {
      throw AppLocalizationsGeneratorException(
          "path: '$path' returned multiple ($size) results");
    } else {
      final result = results.first;
      final content = await buildStep.readAsString(result);
      return loadYaml(content);
    }
  }

  @override
  dynamic generateForAnnotatedElement(
      Element element, ConstantReader annotation, BuildStep buildStep) async {
    final yamlStringsPath = annotation.read('yamlStringsPath').stringValue;
    final List<String> supportedLocals = annotation
        .read('supportedLocals')
        .listValue
        .map((x) => x.toStringValue())
        .toList();
    final String name = annotation.read('name').stringValue;
    final yamlMap = await _toYamlMap(yamlStringsPath, buildStep);
    if (yamlMap is YamlMap) {
      final strings = StringsBuilder().buildFromYaml(yamlMap);
      return AppLocalizationsDartBuilder()
          .buildDartFile(name, strings, supportedLocals);
    } else {
      throw AppLocalizationsGeneratorException(
          "yaml found at $yamlStringsPath is not a YamlMap");
    }
  }
}
