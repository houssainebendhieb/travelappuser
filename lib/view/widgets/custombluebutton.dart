import 'package:flutter/material.dart';

class CustomBlueButton extends StatelessWidget {
  final String text;
  final Function ontap;
  final Color color;
  const CustomBlueButton(
      {required this.text,
      required this.color,
      super.key,
      required this.ontap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        ontap();
      },
      child: Container(
        width: MediaQuery.sizeOf(context).width,
        height: MediaQuery.sizeOf(context).height * 0.07,
        decoration: BoxDecoration(
            color: color, borderRadius: BorderRadius.circular(50)),
        child: Center(
          child: Text(text,
              style: const TextStyle(fontSize: 23, color: Colors.white)),
        ),
      ),
    );
  }
}
