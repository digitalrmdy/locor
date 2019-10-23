library localization_annotation;

class GenerateAppLocalizationsConfig {
  final String name;
  final String yamlStringsPath;
  final List<String> supportedLocals;
  const GenerateAppLocalizationsConfig({this.name, this.yamlStringsPath, this.supportedLocals}) : assert(name!=null && yamlStringsPath!=null && supportedLocals!=null);
}