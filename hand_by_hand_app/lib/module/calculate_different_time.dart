import 'package:intl/intl.dart';

String calculateDifferentTime(DateTime pastTime) {
  // Get the current time
  DateTime now = DateTime.now();

  // Calculate the time difference
  Duration difference = now.difference(pastTime);

  var thaiFormatter = DateFormat.yMEd('th_TH');

  // Display the appropriate time difference based on the value
  if (difference.inSeconds < 60) {
    return '${difference.inSeconds} วินาที';
  } else if (difference.inMinutes < 60) {
    return '${difference.inMinutes} นาที';
  } else if (difference.inHours < 24) {
    return '${difference.inHours} ชั่วโมง';
  } else {
    int buddhistYear = pastTime.year + 543;
    String formatDate = thaiFormatter.format(pastTime);
    formatDate = formatDate.replaceAll('${pastTime.year}', '$buddhistYear');
    return formatDate;
  }
}
