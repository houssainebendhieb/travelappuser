import 'package:flutter/material.dart';

Widget getButtonUI(String text, bool isSelected) {

  return Expanded(
    child: Container(
      decoration: BoxDecoration(
          color: isSelected ? Color(0xFF00B6F0) : Color(0xFFFFFFFF),
          borderRadius: const BorderRadius.all(Radius.circular(24.0)),
          border: Border.all(color: Color(0xFF00B6F0))),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          splashColor: Colors.white24,
          borderRadius: const BorderRadius.all(Radius.circular(24.0)),
          onTap: () {
            /* setState(() {
              categoryType = categoryTypeData;
            });*/
          },
          child: Padding(
            padding:
                const EdgeInsets.only(top: 12, bottom: 12, left: 18, right: 18),
            child: Center(
              child: Text(
                text,
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 12,
                  letterSpacing: 0.27,
                  color: isSelected ? Color(0xFFFFFFFF) : Color(0xFF00B6F0),
                ),
              ),
            ),
          ),
        ),
      ),
    ),
  );
}
