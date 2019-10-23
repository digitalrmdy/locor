import '../models/models.dart';
import 'package:yaml/yaml.dart';

class StringsBuilder {
  Strings buildFromYaml(YamlMap yaml) {
    Strings root = Strings();
    _convertYamlMap(root, yaml, 0);
    return root;
  }

  void _convertYamlMap(StringsContainer parent, YamlMap yamlMap, int level) {
    yamlMap.forEach((key, value) {
     final p = StringsContainer(key, parent);
      parent.addStringParent(p);
      if (value is YamlMap) {
        _convertYamlMap(p, value, level + 1);
      } else if (value is YamlScalar) {
        _convertYamlScalar(p, value);
      } else if (!(value is YamlNode)) {
        _convertLiteral(p, value.toString());
      } else {
        throw StringsBuilderException(
            "don't know what to do with this: ${value.runtimeType} { $value }");
      }
    });
  }


  List<StringValueArg> _extractArgs(String str) {
    final args = StringValueArgsMatcher().findMatches(str);
    if(args.contains(null))
    throw Exception("error null args");
    return args.map((a)=>StringValueArg(a)).toList();
  }

  void _convertLiteral(StringsContainer parent, Object literal) {
    final value = literal.toString();
    parent.addStringChild(escapeIllegalVariables(value), _extractArgs(value));
  }

  void _convertYamlScalar(StringsContainer parent, YamlScalar yamlScalar) {
   _convertLiteral(parent, yamlScalar.toString());
  }
}

class StringsBuilderException implements Exception {
  final String cause;

  StringsBuilderException(this.cause);

  @override
  String toString() {
    return "$StringsBuilder: $cause";
  }
}

String escapeIllegalVariables(String value) {
  //in case message contains something like 'x costs $5', make sure it's escaped
  return value.replaceAllMapped(RegExp(r"\$(\d+)"), (m)=>"\\\$${m.group(1)}");
}


class StringValueArgsMatcher {
 static RegExp _argsRegExp = RegExp(
     r'\$[a-z]+[a-z0-9]*',
    caseSensitive: false,
    multiLine: false,
  );

  List<String> findMatches(String input) {
    return _argsRegExp.allMatches(input).map((m)=>m.group(0).replaceAll(RegExp(r"[\{\}\$]"), "")).where((m)=>m.isNotEmpty).toList();

  }
}