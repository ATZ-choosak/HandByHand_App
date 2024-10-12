import 'package:flutter/material.dart';

class ButtonLoading extends StatelessWidget {
  const ButtonLoading({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: 50,
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(
            Radius.circular(90)),
        color: Theme.of(context).primaryColor,
      ),
      child: const CircularProgressIndicator(
        color: Colors.white,
      ),
    );
  }
}