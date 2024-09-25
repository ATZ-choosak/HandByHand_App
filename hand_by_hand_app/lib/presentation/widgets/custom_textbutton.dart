import 'package:flutter/material.dart';

class CustomTextbutton extends StatelessWidget {
  const CustomTextbutton(
      {super.key, required this.buttonText, required this.submit});

  final String buttonText;
  final Function submit;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () => submit(),
      style: const ButtonStyle(
        overlayColor: WidgetStatePropertyAll(
          Colors.transparent,
        ),
      ),
      child: Text(
        buttonText,
        style: TextStyle(
            color: Theme.of(context).primaryColorLight,
            fontWeight: FontWeight.bold),
      ),
    );
  }
}
