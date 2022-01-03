///generate an AppLocalizations class with [name] based on yaml found at [yamlStringsPath] for [supportedLocals]
class GenerateAppLocalizationsConfig {
  ///name of the class, e.g 'AppLocalizations'
  final String name;

  ///the path where the yaml is located. must be in the lib folder, e.g. 'libs/l10n/strings.yaml'
  final String yamlStringsPath;

  ///list of locals that are supported, e.g ['en', 'nl']
  final List<String> supportedLocals;

  final SeparatorStyle separatorStyle;

  const GenerateAppLocalizationsConfig(
      {required this.name,
      required this.yamlStringsPath,
      required this.supportedLocals,
      this.separatorStyle = SeparatorStyle.CamelCase});
}

//How the yaml keys should be joined together into getters
enum SeparatorStyle {
  ///method name for keys common.appName:
  ///common_appName
  Underscore,

  ///method name for keys common.appName:
  ///commonAppName
  CamelCase
}
