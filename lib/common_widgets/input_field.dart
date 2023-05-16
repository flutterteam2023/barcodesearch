// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class InputField extends StatelessWidget {
  InputField({
    required this.suffixIcon,
    this.controller,
    required this.hintText,
    super.key,
    this.validator,
    this.obscureText = false,
    this.onChanged,
    this.maxLength,
  });
  final String hintText;
  final bool obscureText;
  final Widget suffixIcon;
  final TextEditingController? controller;
  final Function(String)? onChanged;
  String? Function(String?)? validator;
  int? maxLength;
  Color textWhiteGrey = const Color(0xfff1f1f5);
  Color textGrey = const Color(0xff94959b);
  TextStyle heading6 = const TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w500,
  );
  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: textWhiteGrey,
        borderRadius: BorderRadius.circular(14),
      ),
      child: TextFormField(
        maxLength: maxLength,
        controller: controller,
        obscureText: obscureText,
        validator: validator,
        onChanged: onChanged,
        decoration: InputDecoration(
          counterText: '',
          hintText: hintText,
          hintStyle: heading6.copyWith(color: textGrey),
          border: const OutlineInputBorder(
            borderSide: BorderSide.none,
          ),
          suffixIcon: suffixIcon,
        ),
      ),
    );
  }
}
