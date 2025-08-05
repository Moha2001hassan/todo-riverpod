import 'package:flutter/material.dart';
import 'package:todo_riverpod/utils/styles.dart';

class CommonTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final bool? isObscure;
  final TextInputType? keyboardType;

  const CommonTextField({
    super.key,
    required this.controller,
    required this.hintText,
    this.isObscure,
    this.keyboardType,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType ?? TextInputType.text,
      obscureText: isObscure ?? false,
      textDirection: TextDirection.ltr,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: AppStyles.normalTextStyle,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: const BorderSide(color: Colors.grey),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: const BorderSide(color: Colors.grey),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: const BorderSide(color: Colors.blue),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 10),
      ),
    );
  }
}
