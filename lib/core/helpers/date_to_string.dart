import 'package:intl/intl.dart';

String dateToString(
  DateTime date, {
  bool isArabic = false,
}) {
  if (isArabic) {
    return DateFormat('dd MMMM yyyy', 'ar').format(date);
  }
  return DateFormat('dd MMMM yyyy').format(date);
}
