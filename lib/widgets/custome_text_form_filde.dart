import 'package:flutter/material.dart';
import 'package:marvel/helpers/constants.dart';

class CustomTextFormFiled extends StatelessWidget {
  const CustomTextFormFiled({
    super.key,
    required this.label,
    this.hint,
    required this.textEditingController,
    required this.validate,
    required this.isPassword,
    this.prefixIcon,
    this.suffixIcon,
  });

  final String? label;
  final String? hint;
  final TextEditingController textEditingController;
  final FormFieldValidator<String?> validate;
  final bool isPassword;
  final Widget? prefixIcon;
  final Widget? suffixIcon;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: textEditingController,
      validator: validate,
      obscureText: isPassword,
      decoration: InputDecoration(
        hintText: hint,
        label: label == null ? null : Text(label!),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.blue),
        ),
        focusColor: mainColor,
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
      ),
    );
  }
}
