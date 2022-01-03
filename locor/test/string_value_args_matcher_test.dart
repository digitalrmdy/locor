import 'package:flutter_test/flutter_test.dart';
import 'package:locor/src/stringsmetadatabuilder/strings_builder.dart';

void main() {
  test("test StringValueArgsMatcher", () {
    final input = '''hello,\$5 \$a \$surName''';
    final matches = StringValueArgsMatcher().findMatches(input);
    print(matches);
    print(
        input.replaceAllMapped(RegExp(r"\$(\d+)"), (m) => "\\\$${m.group(1)}"));
    expect(matches.length, 2);
    //TODO proper testing
  });
}
