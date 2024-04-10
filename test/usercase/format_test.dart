import 'package:financas_pessoais/usercase/format_date.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('formata data', () {
    test('espero que retorne 115,00', () {
      var r = Format.currentFormat(115);
      expect(r, equals('115,00'));
    });

    test('espero que retorne 1.500,00', () {
      var r = Format.currentFormat(1500);
      expect(r, equals('1.500,00'));
    });

    test('espero que retorne 100.000,00', () {
      var r = Format.currentFormat(100000);
      expect(r, equals('100.000,00'));
    });

    test('espero que retorne 110.000.000,00', () {
      var r = Format.currentFormat(110000000);
      expect(r, equals('110.000.000,00'));
    });
  });
}
