import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    required this.hintText, required this.textInputType, required this.obscureText, super.key,
    this.onChanged,
  });
  final String hintText;
  final TextInputType textInputType;
  final bool obscureText;
  final void Function(String)? onChanged;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 58,
      child: TextField(
        onChanged: onChanged,
        obscureText: obscureText,
        obscuringCharacter: obscureText == true ? '*' : ' ',
        keyboardType: textInputType,
        style: const TextStyle(
            color: Colors.white,
            fontSize: 14,
            fontWeight: FontWeight.w400,
            fontFamily: 'Raleway Regular',),
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: const TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.w400,
              fontFamily: 'Raleway Regular',),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: const BorderSide(color: Colors.white),),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: const BorderSide(color: Colors.white),),
          filled: true,
        ),
      ),
    );
  }
}
