// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

import '../theme/theme.dart';

class CustomTextField extends StatelessWidget {
  final String hintText;
  final bool obscureText;
  final Widget? suffixIcon;
  TextEditingController? controller;
  CustomTextField({
    super.key,
    required this.hintText,
    this.suffixIcon,
    this.controller,
    this.obscureText = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 16),
      height: 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [
          BoxShadow(
            blurRadius: 4,
            color: Color(0x40000000),
            offset: Offset(0, 1),
            spreadRadius: 0,
          ),
        ],
        color: whiteColor,
      ),
      width: MediaQuery.of(context).size.width,
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        decoration: InputDecoration(
          suffixIcon: suffixIcon,
          border: InputBorder.none,
          hintText: hintText,
          hintStyle:
              lightTextStyle.copyWith(fontSize: 15, color: greyLightColor),
        ),
      ),
    );
  }
}
