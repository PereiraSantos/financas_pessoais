import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

class Format {
  Format() {
    initializeDateFormatting();
    Intl.defaultLocale = 'pt_BR';
  }

  static currentFormat(double number) {
    try {
      return NumberFormat("#,##0.00", "pt_BR").format(number);
    } catch (e) {
      return number;
    }
  }

  static String formatDate(DateTime date) => DateFormat('dd/MM/yyyy').format(date);

  static String formatDateWek(String date) =>
      date != '' ? DateFormat("EEEE", "pt_BR").format(dateParse(date)).replaceAll("-feira", "") : '';

  static String formatDateMonth(String date) =>
      date != '' ? DateFormat("MMMM", "pt_BR").format(dateParse(date)) : '';

  static String formatDateDayMonth(String date) =>
      date != '' ? DateFormat("d/MMMM", "pt_BR").format(dateParse(date)) : '';

  static String formatDateString(String date) =>
      date != '' ? DateFormat("dd/MM/yyyy").format(dateParse(date)) : '';

  static String formatDateStringDayMonth(String date) =>
      date != '' ? DateFormat("dd/MM").format(dateParse(date)) : '';

  static DateTime dateParse(String date) => DateFormat('dd/MM/yyyy').parse(date);
}
