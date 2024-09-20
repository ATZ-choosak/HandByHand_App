import 'package:flutter/material.dart';

class ImageFilter extends StatelessWidget {
  const ImageFilter({super.key, required this.child, required this.brightness});

  final Widget child;
  final double brightness;

  @override
  Widget build(BuildContext context) {
    return ColorFiltered(
        colorFilter: ColorFilter.matrix([
          1,
          0,
          0,
          0,
          brightness,
          0,
          1,
          0,
          0,
          brightness,
          0,
          0,
          1,
          0,
          brightness,
          0,
          0,
          0,
          1,
          0,
        ]),
        child: child);
  }
}
