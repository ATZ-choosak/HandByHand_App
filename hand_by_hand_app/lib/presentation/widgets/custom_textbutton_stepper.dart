import 'package:flutter/material.dart';

class CustomTextbuttonStepper extends StatelessWidget {
  const CustomTextbuttonStepper(
      {super.key,
      required this.buttonText,
      required this.submit,
      required this.buttonColor,
      this.disabled = false});

  final String buttonText;
  final Function submit;
  final Color buttonColor;
  final bool disabled;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () => disabled ? null : submit(),
      style: const ButtonStyle(
        overlayColor: WidgetStatePropertyAll(
          Colors.transparent,
        ),
      ),
      child: Text(
        buttonText,
        style: TextStyle(color: buttonColor, fontWeight: FontWeight.bold),
      ),
    );
  }
}
