import 'package:flutter/material.dart';

class AvatarNoImage extends StatelessWidget {
  const AvatarNoImage({
    super.key,
    required this.username,
    this.fontSize = 70, this.radius,
  });

  final String username;
  final double? fontSize, radius;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: radius,
      backgroundColor: Theme.of(context).primaryColorLight,
      child: Text(
        textAlign: TextAlign.center,
        username.isNotEmpty ? username[0].toUpperCase() : "",
        style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: fontSize),
      ),
    );
  }
}
