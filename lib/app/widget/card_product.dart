// ignore_for_file: prefer_interpolation_to_compose_strings

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:online_medicine/app/theme/theme.dart';

class CardProduct extends StatelessWidget {
  const CardProduct(
      {Key? key,
      required this.imageProduct,
      required this.nameProduct,
      required this.price})
      : super(key: key);
  final String imageProduct;
  final String nameProduct;
  final String price;

  @override
  Widget build(BuildContext context) {
    final priceFormat = NumberFormat("#,##0", "en_US");
    return Container(
      decoration: BoxDecoration(
        color: whiteColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          Image.network(
            imageProduct,
            width: 120,
            height: 70,
            fit: BoxFit.cover,
          ),
          const SizedBox(
            height: 14,
          ),
          Text(
            nameProduct,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
            style: regularTextStyle,
          ),
          const SizedBox(
            height: 12,
          ),
          Text(
            "KGS  " +
                priceFormat.format(
                  int.parse(price),
                ),
            style: boldTextStyle,
          ),
        ],
      ),
    );
  }
}
