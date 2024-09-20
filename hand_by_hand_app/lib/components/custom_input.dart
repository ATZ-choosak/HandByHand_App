import 'package:flutter/material.dart';

class CustomInput extends StatelessWidget {
  const CustomInput({
    super.key,
    required TextEditingController inputController,
    required this.icon,
    required this.hintText,
    required this.labelText,
    required this.validateText,
  }) : _inputController = inputController;

  final TextEditingController _inputController;
  final Icon icon;
  final String hintText;
  final String labelText;
  final String validateText;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: _inputController,
      decoration: InputDecoration(
          icon: icon,
          hintText: hintText,
          hintStyle: TextStyle(color: Colors.grey[500]),
          labelText: labelText,
          focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Theme.of(context).primaryColor)),
          floatingLabelStyle: TextStyle(color: Theme.of(context).primaryColor)),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return validateText;
        }
        return null;
      },
    );
  }
}
