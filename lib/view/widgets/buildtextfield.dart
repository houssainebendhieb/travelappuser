import 'package:flutter/material.dart';

bool showPassword = false;
Widget buildTextField(String labelText, bool isPasswordTextField, Icon icon,
    TextEditingController controller) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 35.0),
    child: TextField(
      controller: controller,
      obscureText: isPasswordTextField ? showPassword : false,
      decoration: InputDecoration(
          prefixIcon: icon,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(100)),
          suffixIcon: icon == Icon(Icons.password)
              ? IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.remove_red_eye,
                    color: Colors.grey,
                  ),
                )
              : null,
          contentPadding: const EdgeInsets.only(bottom: 3),
          labelText: labelText,
          floatingLabelBehavior: FloatingLabelBehavior.always,
          hintStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          )),
    ),
  );
}
