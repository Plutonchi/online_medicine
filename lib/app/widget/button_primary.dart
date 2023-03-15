// ignore_for_file: sort_child_properties_last, sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:online_medicine/app/theme/theme.dart';

class ButtonPrimary extends StatelessWidget {
  const ButtonPrimary({Key? key, required this.text, required this.onTap})
      : super(key: key);
  final String text;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width - 100,
      height: 50,
      child: ElevatedButton(
        onPressed: onTap,
        child: Text(
          text,
          style: regularTextStyle.copyWith(
            fontSize: 20,
          ),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: greenColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
      ),
    );
  }
}
