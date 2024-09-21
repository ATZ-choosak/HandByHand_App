import 'package:flutter/material.dart';

void pageRouteNotReturn(BuildContext context, Widget page) {
  WidgetsBinding.instance.addPostFrameCallback((_) async {
    await Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (_) => page,
      ),
      (Route<dynamic> route) => false,
    );
  });
}
