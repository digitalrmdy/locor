import '../../locor.dart';
import '../util/string_utils.dart';

abstract class StringNode {
  String? get key;
  StringNode? get parent;
}

class Strings extends StringsContainer {
  Strings() : super(null, null);

  @override
  String toString() {
    return 'Strings{$children}';
  }
}

class StringsContainer implements StringNode {
  @override
  final StringsContainer? parent;
  @override
  final String? key;
  final List<StringNode> children = [];

  void addStringParent(StringsContainer parent) {
    children.add(parent);
  }

  void addStringChild(String value, List<StringValueArg> args) {
    children.add(StringValue(this, value, args));
  }

  StringsContainer(this.key, this.parent);

  @override
  String toString() {
    final parentName = parent is Strings ? "root" : parent?.key;
    return '$StringsContainer{parent: $parentName, key: $key, _children: $children}';
  }
}

class StringValue extends StringNode {
  @override
  final StringsContainer parent;
  final String value;
  final List<StringValueArg> args;

  String generateMethodName(SeparatorStyle separatorStyle) {
    switch (separatorStyle) {
      case SeparatorStyle.Underscore:
        return _lookupFullKeys(this).join("_");
      case SeparatorStyle.CamelCase:
        return toCamelCase(_lookupFullKeys(this));
    }
  }

  @override
  String? get key => parent.key;

  StringValue(this.parent, this.value, this.args);

  @override
  String toString() {
    final parentName = parent is Strings ? "root" : parent.key;
    return '$StringValue{parent: $parentName, value: "$value", args: $args}';
  }
}

class StringValueArg {
  final String key;

  StringValueArg(this.key);

  @override
  String toString() {
    return '$StringValueArg{key: $key}';
  }
}

List<String> _lookupFullKeys(StringValue child) {
  StringNode? p = child.parent;
  List<String> keys = [];

  while (p?.key != null) {
    keys.insert(0, p!.key!);
    p = p.parent;
  }
  return keys;
}
