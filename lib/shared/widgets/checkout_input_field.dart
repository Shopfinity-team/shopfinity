import 'package:flutter/material.dart';

import '../../theme/app_colors.dart';

class InputField extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final String? hintText;
  final IconButton? suffixIcon;
  final String? Function(String?)? validator;
  const InputField({
    super.key,
    required this.labelText,
    this.hintText,
    this.suffixIcon,
    required this.controller,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      autovalidateMode:
          AutovalidateMode.onUserInteraction, //clear error message after typing
      cursorColor: AppColors.primaryText,
      maxLines: null, //get space as it want
      decoration: InputDecoration(
        alignLabelWithHint: true,
        labelText: labelText,
        hintText: hintText,
        labelStyle: TextStyle(
          color: Theme.of(context).textTheme.bodySmall?.color,
        ),
        hintStyle: TextStyle(
          color: Theme.of(context).textTheme.bodySmall?.color,
        ),
        focusedBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: AppColors.primaryText, width: 1)),
        suffixIcon: suffixIcon,
        errorStyle: const TextStyle(color: Colors.redAccent),
        errorBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.redAccent)),
      ),
      validator: validator,
    );
  }
}
