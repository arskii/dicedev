import 'package:flutter/material.dart';

class CustomField extends StatelessWidget {
  final String title;
  final TextEditingController? controller;
  final Function()? onTap;

  const CustomField(
      {super.key, required this.title, this.controller, this.onTap});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      onTap: onTap,
      decoration: InputDecoration(
        labelText: title,
        border: const OutlineInputBorder(),
      ),
    );
  }
}
