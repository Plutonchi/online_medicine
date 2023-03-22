import 'package:flutter/material.dart';
import 'package:online_medicine/app/theme/theme.dart';

class CardCategory extends StatelessWidget {
  const CardCategory({
    Key? key,
    required this.imageCategory,
    required this.nameCategory,
  }) : super(key: key);

  final String imageCategory;
  final String nameCategory;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset(
          imageCategory,
          width: 65,
          fit: BoxFit.cover,
        ),
        const SizedBox(
          height: 7,
        ),
        Text(
          nameCategory,
          textAlign: TextAlign.center,
          style: mediumTextStyle.copyWith(fontSize: 15),
        ),
      ],
    );
  }
}
