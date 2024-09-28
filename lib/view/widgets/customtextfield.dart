import 'package:flutter/material.dart';

// ignore: must_be_immutable, camel_case_types
class customTextField extends StatelessWidget {
  final String hintText;
  final Icon? icon;
  final TextEditingController controller;
  String? type;
  Icon? preicon;
  customTextField(
      {super.key,
      this.type,
      this.icon,
      required this.controller,
      required this.hintText,
      this.preicon});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (value) {
        if (value == null || value.isEmpty || value.trim().isEmpty) {
          return "invalid  $hintText  ";
        }
        return null;
      },
      controller: controller,
      keyboardType: type != null ? TextInputType.phone : null,
      decoration: InputDecoration(
        hintText: hintText,
        prefixIcon: icon,
        enabledBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            borderSide: BorderSide(color: Colors.black12)),
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          borderSide: BorderSide(
            color: Colors.black12,
            width: 2.0,
          ),
        ),
        focusedBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          borderSide: BorderSide(width: 2.0, color: Colors.black12),
        ),
      ),
    );
  }
}
