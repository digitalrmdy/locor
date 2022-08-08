import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:glob/glob.dart';
import 'package:source_gen/source_gen.dart';
import 'package:yaml/yaml.dart';

import '../../locor.dart';
import '../dartbuilders/app_localizations_dart_builder.dart';
import '../exceptions/exceptions.dart';
import '../stringsmetadatabuilder/strings_builder.dart';

class AppLocalizationsGenerator extends GeneratorForAnnotation<GenerateAppLocalizations> {
  const AppLocalizationsGenerator();

  Future<YamlMap> _toYamlMap(String path, BuildStep buildStep) async {
    List<AssetId> results = await buildStep.findAssets(Glob(path)).toList();
    final size = results.length;
    if (size == 0) {
      throw AppLocalizationsGeneratorException("path: '$path' could not be found");
    } else if (size > 1) {
      throw AppLocalizationsGeneratorException("path: '$path' returned multiple ($size) results");
    } else {
      final result = results.first;
      final content = await buildStep.readAsString(result);
      return loadYaml(content);
    }
  }

  ConstantReader readParam(ConstantReader annotation, String parameter) {
    final reader = annotation.read(parameter);
    if (reader.isNull) {
      throw AppLocalizationsGeneratorException('$parameter is required');
    }
    return reader;
  }

  @override
  dynamic generateForAnnotatedElement(
      Element element, ConstantReader annotation, BuildStep buildStep) async {
    final yamlStringsPath = readParam(annotation, 'yamlStringsPath').stringValue;
    final List<String> supportedLocals =
        readParam(annotation, 'supportedLocals').listValue.map((x) {
      final stringValue = x.toStringValue();
      if (stringValue == null) throw AppLocalizationsGeneratorException("Local not recognized");
      return x.toStringValue() ?? "";
    }).toList();

    final separatorParam = readParam(annotation, 'separatorStyle');
    final SeparatorStyle separatorStyle = separatorParam.enumValue(SeparatorStyle.values);
    final String name = readParam(annotation, 'name').stringValue;
    final yamlMap = await _toYamlMap(yamlStringsPath, buildStep);
    if (yamlMap is YamlMap) {
      final strings = StringsBuilder().buildFromYaml(yamlMap);
      return AppLocalizationsDartBuilder()
          .buildDartFile(name, strings, supportedLocals, separatorStyle);
    } else {
      throw AppLocalizationsGeneratorException("yaml found at $yamlStringsPath is not a YamlMap");
    }
  }
}

extension on ConstantReader {
  T enumValue<T>(Iterable<T> selectFrom) {
    return selectFrom.firstWhere((enumType) {
      String? enumValue = this.objectValue.getField("_name")?.toStringValue();
      if (enumValue == null) return false;
      return enumType.toString().split('.')[1] == enumValue;
    }, orElse: () => selectFrom.last);
  }
}
