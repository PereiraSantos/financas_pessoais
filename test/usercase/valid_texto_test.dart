import 'package:financas_pessoais/usercase/valid_text.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group("Valida texto", () {
    test("Espero false no validTextIsBig", () {
      var r = ValidText.validTextIsBig(
          'aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa');
      expect(r, false);
    });

    test("Espero true no validTextIsBig", () {
      var r = ValidText.validTextIsBig('aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa');
      expect(r, true);
    });

    test("Espero false validTextIsNull", () {
      var r = ValidText.validTextIsNull('');
      expect(r, false);
    });
    test("Espero  true validTextIsNull", () {
      var r = ValidText.validTextIsNull('aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa');
      expect(r, true);
    });
  });
}
