import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton(
      {super.key,
      required this.submit,
      required this.buttonText,
      this.disabled = false});

  final Function submit;
  final String buttonText;
  final bool disabled;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 130,
      height: 50,
      child: ElevatedButton(
        onPressed: () => disabled ? null : submit(),
        style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            backgroundColor: disabled ? Theme.of(context).primaryColorDark : Theme.of(context).primaryColor,
            foregroundColor: Colors.white),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(buttonText),
            const SizedBox(
                height: 20, width: 20, child: Icon(Icons.arrow_forward)),
          ],
        ),
      ),
    );
  }
}
