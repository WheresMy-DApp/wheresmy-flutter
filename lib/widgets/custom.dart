import 'package:flutter/material.dart';

Widget customButton(String text,
    {required Function() onTap,
    bool isFilled = true,
    Color textColor = const Color(0xFFF3F3F3)}) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      height: double.infinity,
      width: double.infinity,
      decoration: BoxDecoration(
        border: isFilled ? null : Border.all(color: const Color(0xFFF3F3F3)),
        borderRadius: BorderRadius.circular(10),
        gradient: isFilled
            ? const LinearGradient(
                colors: <Color>[
                  Color(0xFF9C77F5),
                  Color(0xFF7751F1),
                ],
              )
            : null,
      ),
      child: Center(
        child: Text(
          text,
          style: TextStyle(
            color: textColor,
            fontSize: 16,
            fontWeight: FontWeight.w800,
          ),
        ),
      ),
    ),
  );
}

Widget customTextFormField(TextEditingController controller, String label,
    {IconData? suffixIcon, bool isObscure = false}) {
  return TextFormField(
    controller: controller,
    obscureText: isObscure,
    decoration: InputDecoration(
      suffixIcon: Icon(
        suffixIcon,
        color: const Color(
          0xFF9C9C9C,
        ),
      ),
      filled: true,
      labelText: label,
      labelStyle: const TextStyle(
        color: Color(
          0xFF9C9C9C,
        ),
      ),
      border: const OutlineInputBorder(
        // borderSide: BorderSide.none,
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      // border: InputBorder.none,
      focusedBorder: const OutlineInputBorder(
        // borderSide: BorderSide.none,
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      enabledBorder: const OutlineInputBorder(
        // borderSide: BorderSide.none,
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      errorBorder: const OutlineInputBorder(
        // borderSide: BorderSide.none,
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      disabledBorder: InputBorder.none,
      fillColor: const Color(
        0xFF191919,
      ),
    ),
  );
}
