import 'package:flutter/material.dart';

class CustomField extends StatelessWidget {
  final String title;
  final TextEditingController? controller;
  final Function()? onTap;
  final bool obscureText;

  const CustomField(
      {super.key,
      required this.title,
      this.controller,
      this.onTap,
      this.obscureText = false});

  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: obscureText,
      controller: controller,
      onTap: onTap,
      decoration: InputDecoration(
        labelText: title,
        border: const OutlineInputBorder(),
      ),
    );
  }
}
