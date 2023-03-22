// ignore_for_file: library_private_types_in_public_api, sized_box_for_whitespace, prefer_interpolation_to_compose_strings

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:online_medicine/app/data/model/model.dart';
import 'package:online_medicine/app/theme/theme.dart';
import 'package:online_medicine/app/widget/button_primary.dart';

class DetailProduct extends StatefulWidget {
  final ProductModel productModel;

  const DetailProduct(
    this.productModel, {
    Key? key,
  }) : super(key: key);

  @override
  _DetailProductState createState() => _DetailProductState();
}

class _DetailProductState extends State<DetailProduct> {
  final priceFormat = NumberFormat("#,##0", "en_US");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          children: [
            Container(
              padding: const EdgeInsets.fromLTRB(5, 24, 30, 0),
              height: 70,
              child: Row(
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(
                      Icons.arrow_back_ios_new,
                      size: 30,
                      color: greenColor,
                    ),
                  ),
                  const SizedBox(
                    width: 30,
                  ),
                  Text(
                    'Detail Product',
                    style: regularTextStyle.copyWith(fontSize: 25),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 24,
            ),
            Container(
              height: 200,
              color: whiteColor,
              child: Image.network(
                widget.productModel.imageProduct,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.productModel.nameProduct,
                    style: regularTextStyle.copyWith(fontSize: 20),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Text(
                    widget.productModel.description,
                    textAlign: TextAlign.justify,
                    style: regularTextStyle.copyWith(
                        fontSize: 14, color: greyBoldColor),
                  ),
                  const SizedBox(
                    height: 65,
                  ),
                  Row(
                    children: [
                      const Spacer(),
                      Text(
                        "KGS  " +
                            priceFormat.format(
                              int.parse(widget.productModel.price),
                            ),
                        style: boldTextStyle.copyWith(fontSize: 20),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    child: ButtonPrimary(
                      text: "ADD TO CART",
                      onTap: () {},
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
