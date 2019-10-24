library localization_annotation;

///generate an AppLocalizations class with [name] based on yaml found at [yamlStringsPath] for [supportedLocals]
class GenerateAppLocalizationsConfig {
  ///name of the class, e.g 'AppLocalizations'
  final String name;

  ///the path where the yaml is located. must be in the lib folder, e.g. 'libs/l10n/strings.yaml'
  final String yamlStringsPath;

  ///list of locals that are supported, e.g ['en', 'nl']
  final List<String> supportedLocals;
  const GenerateAppLocalizationsConfig(
      {this.name, this.yamlStringsPath, this.supportedLocals});
}
