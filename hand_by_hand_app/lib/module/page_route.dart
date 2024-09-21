import 'package:flutter/material.dart';

void pageRoute(BuildContext context, Widget page) {
  WidgetsBinding.instance.addPostFrameCallback((_) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => page,
      ),
    );
  });
}
