import 'package:intl/intl.dart';

String getCurrentDate() {
  return DateFormat('d-MMM-y').format(DateTime.now());
}

String getCurrentDayAndTime(DateTime dateTime) {
  return DateFormat('d-MMM-y E HH:mm:ss a').format(dateTime);
}
