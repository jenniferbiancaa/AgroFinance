import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

extension DateTimeFormatter on DateTime {
  String get toText {
    if (isAfter(DateTime.now().subtract(const Duration(days: 1)))) {
      return 'Hoje';
    }
    if (isAfter(DateTime.now().subtract(const Duration(days: 2))) &&
        isBefore(DateTime.now().subtract(const Duration(days: 1)))) {
      return 'Ontem';
    }
    initializeDateFormatting('pt_BR', null);
    const brazilianLocale = 'pt_BR';
    final dateFormat = DateFormat('EEE, d MMM y', brazilianLocale);
    return dateFormat.format(this);
  }

  String get formatISOTime {
    var duration = timeZoneOffset;
    if (duration.isNegative) {
      return ("${toIso8601String().replaceAll('Z', '-')}${duration.inHours.toString().padLeft(2, '0')}:${(duration.inMinutes - (duration.inHours * 60)).toString().padLeft(2, '0')}");
    } else {
      return ("${toIso8601String().replaceAll('Z', '+')}${duration.inHours.toString().padLeft(2, '0')}:${(duration.inMinutes - (duration.inHours * 60)).toString().padLeft(2, '0')}");
    }
  }
}
