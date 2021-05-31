import 'package:code_builder/code_builder.dart';
import 'package:dart_style/dart_style.dart';
import 'package:localization_annotation/localization_annotation.dart';
import 'package:localization_builder/src/util/string_utils.dart';

import '../models/models.dart';
import '../util/generator_utils.dart';

class AppLocalizationsDartBuilder {
  String buildDartFile(
      String name, Strings strings, List<String> supportedLocals, SeparatorStyle separatorStyle) {
    final lib = Library((b) => b.body.addAll([
          _AppLocalizationsBuilder(name).build(strings, separatorStyle),
          _AppLocalizationsDelegateBuilder(name).build(supportedLocals),
        ]));
    final emitter = DartEmitter();
    return DartFormatter().format('${lib.accept(emitter)}');
  }
}

class _AppLocalizationsDelegateBuilder {
  final String appLocalizationsClassName;

  _AppLocalizationsDelegateBuilder(this.appLocalizationsClassName);
  Class build(List<String> supportedLocals) {
    return Class((b) => b
      ..name = '${appLocalizationsClassName}Delegate'
      ..extend = refer('LocalizationsDelegate<$appLocalizationsClassName>')
      ..constructors.add(Constructor((c) => c..constant = true))
      ..methods.addAll([
        createIsSupportedMethod(supportedLocals),
        createLoadMethod(),
        createShouldReloadMethod()
      ]));
  }

  Method createLoadMethod() {
    return Method((b) => b
      ..name = 'load'
      ..returns = refer('Future<$appLocalizationsClassName>')
      ..requiredParameters.add(Parameter((p) => p
        ..name = 'locale'
        ..type = refer('Locale')))
      ..body = Code('return $appLocalizationsClassName.load(locale);')
      ..annotations.add(refer("override")));
  }

  Method createIsSupportedMethod(List<String> supportedLocals) {
    return Method((b) => b
      ..name = 'isSupported'
      ..returns = refer('bool')
      ..requiredParameters.add(Parameter((p) => p
        ..name = 'locale'
        ..type = refer('Locale')))
      ..body = Code('return [${joinSingleQuoted(supportedLocals)}].contains(locale.languageCode);')
      ..annotations.add(refer("override")));
  }

  Method createShouldReloadMethod() {
    return Method((b) => b
      ..name = 'shouldReload'
      ..returns = refer('bool')
      ..requiredParameters.add(Parameter((p) => p
        ..name = 'old'
        ..type = refer('LocalizationsDelegate<$appLocalizationsClassName>')))
      ..body = Code('return false;')
      ..annotations.add(refer("override")));
  }
}

class _AppLocalizationsBuilder {
  final String name;

  _AppLocalizationsBuilder(this.name);

  String createIgnoreForFileLowerCamelCaseUnderscoreWarning() {
    return "// ignore_for_file: non_constant_identifier_names";
  }

  Class build(StringsContainer strings, SeparatorStyle separatorStyle) {
    return Class((b) => b
      ..docs.addAll([
        if (separatorStyle == SeparatorStyle.Underscore)
          createIgnoreForFileLowerCamelCaseUnderscoreWarning()
      ])
      ..name = name
      ..methods.add(_createLoadMethod())
      ..methods.add(__createOfMethod())
      ..methods.addAll(_StringsBuilder(separatorStyle).build(strings)));
  }

  Method _createLoadMethod() {
    return Method((b) => b
      ..static = true
      ..name = "load"
      ..returns = refer("Future<$name>")
      ..requiredParameters.add(Parameter((p) => p
        ..name = "locale"
        ..type = refer(("Locale"))))
      ..body = Code('''
            final String name = locale.countryCode == null || locale.countryCode!.isEmpty
    ? locale.languageCode : locale.toString();
    String localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
    Intl.defaultLocale = localeName;
    return $name();
    });
        '''));
  }

  Method __createOfMethod() {
    return Method((b) => b
      ..static = true
      ..name = "of"
      ..requiredParameters.add(Parameter((p) => p
        ..name = "context"
        ..type = refer("BuildContext")))
      ..returns = refer("$name?")
      ..body = Code('return Localizations.of<$name>(context, $name);'));
  }
}

class _StringsBuilder {
  final SeparatorStyle separatorStyle;

  const _StringsBuilder(this.separatorStyle);

  List<Method> build(StringsContainer parent) {
    return _createMethods(parent.children);
  }

  List<Method> _createMethods(List<StringNode> nodes) {
    List<Method> methods = [];
    _addMethods(methods, nodes);
    return methods;
  }

  void _addMethods(List<Method> methods, List<StringNode> nodes) {
    nodes.forEach((node) {
      if (node is StringsContainer) {
        _addMethods(methods, node.children);
      } else if (node is StringValue) {
        methods.add(_createMethod(node));
      }
    });
  }

  String createIntlCodeBody(StringValue stringValue) {
    final name = stringValue.generateMethodName(separatorStyle);
    final args = stringValue.args;
    //escape newlines and remove trailing new lines
    var msg = replaceNewLinesWith(removeNewLinesRight(stringValue.value), '\\n');
    String body = "Intl.message('$msg', name: '$name'";
    if (args.isNotEmpty) {
      final argsString = args.map((a) => a.key).join(", ");
      body += ", args: [$argsString]";
    }
    body += ")";
    return body;
  }

  Method _createMethod(StringValue child) {
    return Method((b) => b
      ..name = child.generateMethodName(separatorStyle)
      ..returns = refer("String")
      ..lambda = true
      ..type = child.args.isNotEmpty ? null : MethodType.getter
      ..body = Code(createIntlCodeBody(child))
      ..requiredParameters.addAll(_toParams(child.args)));
  }

  Iterable<Parameter> _toParams(List<StringValueArg> args) {
    return args.map((arg) => Parameter((b) => b..name = arg.key));
  }
}
