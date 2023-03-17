import 'package:flutter/material.dart';
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
    return Container(
      decoration: BoxDecoration(
        color: whiteColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          Image.network(
            imageProduct,
            width: 115,
            height: 76,
          ),
          const SizedBox(
            height: 16,
          ),
          Text(
            nameProduct,
            textAlign: TextAlign.center,
            style: regularTextStyle,
          ),
          const SizedBox(
            height: 14,
          ),
          Text(
            price,
            style: boldTextStyle,
          ),
        ],
      ),
    );
  }
}
