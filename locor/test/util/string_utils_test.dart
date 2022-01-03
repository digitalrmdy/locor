import 'package:flutter_test/flutter_test.dart';
import 'package:locor/src/util/string_utils.dart';

void main() {

  group('test containsNewLines',() {
    test('test strings without new lines',() {
      final String s = "some string";
      expect(containsNewLines(s), equals(false));
    });
    test('test strings with new lines',() {
      final String s ='''some
      string''';
      expect(containsNewLines(s), equals(true));
    });

  });
}