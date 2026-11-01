import 'package:intl/intl.dart';

extension IntExt on int {
  String get toReadableNumber {
    String formattedNumber = NumberFormat('#,###').format(this);
    return formattedNumber;
  }
}
