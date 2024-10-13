import 'package:flutter/material.dart';

class CircleTop extends StatelessWidget {
  const CircleTop({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: -350,
      child: Container(
        width: 560,
        height: 560,
        decoration: BoxDecoration(
            color: Theme.of(context).primaryColor, shape: BoxShape.circle),
      ),
    );
  }
}
