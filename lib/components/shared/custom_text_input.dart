import 'package:flutter/material.dart';

class CustomTextInput extends StatelessWidget {
  const CustomTextInput({
    super.key,
    required this.controller,
    required this.hintText,
    this.icon,
    this.obscureText,
    this.fillBg = false,
  });

  final TextEditingController controller;
  final String? hintText;
  final Widget? icon;
  final bool? obscureText;
  final bool? fillBg;

  @override
  Widget build(BuildContext context) {
    return TextField(
      // TODO: add ObscureText
      controller: controller,
      style: const TextStyle(
        fontFamily: 'Inter',
        fontSize: 18,
        fontWeight: FontWeight.w700,
      ),
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(
          vertical: 15,
          horizontal: 15,
        ),
        icon: icon ?? icon,
        fillColor: Colors.white,
        filled: fillBg,
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),
        labelText: hintText,
      ),
    );
  }
}
