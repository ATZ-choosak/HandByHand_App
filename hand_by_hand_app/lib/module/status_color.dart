import 'package:flutter/material.dart';

Color statusColor(String status) {
  if (status == "pending") {
    return Colors.yellow.shade700;
  }

  if (status == "exchanging") {
    return Colors.orange.shade700;
  }

  if (status == "completed") {
    return Colors.green.shade700;
  }

  return Colors.red.shade700;
}
