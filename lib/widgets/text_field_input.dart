import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../utils/colors.dart';

class TextFieldInput extends StatelessWidget {
  final TextEditingController textController;
  final String labelText;
  final bool isPassword;
  final TextInputType keyboardType;
  const TextFieldInput(
      {Key? key,
      required this.labelText,
      this.isPassword = false,
      required this.textController,
      required this.keyboardType})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textInputBorder = OutlineInputBorder(
      borderRadius: const BorderRadius.all(
        Radius.circular(4.0),
      ),
      borderSide: Divider.createBorderSide(context),
    );
    return TextField(
      controller: textController,
      decoration: InputDecoration(
        hintText: null,
        border: textInputBorder,
        focusedBorder: textInputBorder,
        enabledBorder: textInputBorder,
        filled: true,
        contentPadding: EdgeInsets.all(8),
        label: Text(
          labelText,
          style: TextStyle(color: primaryColor.withOpacity(0.5)),
        ),
      ),
      keyboardType: keyboardType,
      obscureText: isPassword,
    );
  }
}
