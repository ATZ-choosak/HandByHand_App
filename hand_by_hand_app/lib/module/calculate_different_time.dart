String calculateDifferentTime(DateTime pastTime) {

  // Get the current time
  DateTime now = DateTime.now();

  // Calculate the time difference
  Duration difference = now.difference(pastTime);

  // Display the appropriate time difference based on the value
  if (difference.inSeconds < 60) {
    return '${difference.inSeconds} วินาที';
  } else if (difference.inMinutes < 60) {
    return '${difference.inMinutes} นาที';
  } else if (difference.inHours < 24) {
    return '${difference.inHours} ชั่วโมง';
  } else {
    return '${pastTime.toLocal()}';
  }
}
