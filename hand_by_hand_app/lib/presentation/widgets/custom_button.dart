import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton(
      {super.key,
      required this.submit,
      required this.buttonText,
      this.disabled = false,
      this.icon,
      this.width = 130,
      this.height = 50,
      this.useIcon = true});

  final Function submit;
  final String buttonText;
  final bool disabled, useIcon;
  final Icon? icon;
  final double? width, height;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(
        onPressed: () => disabled ? null : submit(),
        style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            backgroundColor: disabled
                ? Theme.of(context).primaryColorDark
                : Theme.of(context).primaryColor,
            foregroundColor: Colors.white),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: useIcon ? MainAxisAlignment.spaceAround : MainAxisAlignment.center,
          children: [
            Text(buttonText),
            useIcon
                ? SizedBox(
                    height: 20,
                    width: 20,
                    child: icon ?? const Icon(Icons.arrow_forward))
                : const SizedBox(),
          ],
        ),
      ),
    );
  }
}
