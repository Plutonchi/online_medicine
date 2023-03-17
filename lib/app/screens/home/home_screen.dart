// ignore_for_file: library_private_types_in_public_api, avoid_print

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:online_medicine/app/data/api/url_api.dart';
import 'package:online_medicine/app/data/model/product_model.dart/product_model.dart';
import 'package:online_medicine/app/theme/theme.dart';
import 'package:online_medicine/app/widget/widget.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<CategoryWithProduct> listCategory = [];
  getCategory() async {
    listCategory.clear();
    var urlCategory = Uri.parse(BASEURL.categoryWithProduct);
    final response = await http.get(urlCategory);
    if (response.statusCode == 200) {
      setState(() {
        final data = jsonDecode(response.body);
        for (Map item in data) {
          listCategory.add(
            CategoryWithProduct.fromJson(item),
          );
          print(listCategory[0].category);
        }
      });
      getProduct();
    }
  }

  List<ProductModel> listProduct = [];
  getProduct() async {
    listProduct.clear();
    var urlProduct = Uri.parse(BASEURL.getProduct);
    final response = await http.get(urlProduct);
    if (response.statusCode == 200) {
      setState(() {
        final data = jsonDecode(response.body);
        for (Map product in data) {
          listProduct.add(
            ProductModel.fromJson(product),
          );
        }
      });
    }
  }

  @override
  void initState() {
    getCategory();
    getProduct();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(24, 30, 24, 30),
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.asset(
                      'assets/images/logo.png',
                      width: 155,
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Text(
                      'Find a medicine or \nvitamins with MEDHEALTH!',
                      style: regularTextStyle.copyWith(
                        fontSize: 15,
                        color: greyBoldColor,
                      ),
                    ),
                  ],
                ),
                IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.shopping_cart_outlined,
                    color: greenColor,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 25,
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              height: 55,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: const Color(
                  0xffe4faf0,
                ),
              ),
              child: TextField(
                decoration: InputDecoration(
                  border: InputBorder.none,
                  prefixIcon: const Icon(
                    Icons.search_outlined,
                    color: Color(0xffb1d8b2),
                  ),
                  hintText: "Search medicine ...",
                  hintStyle: regularTextStyle.copyWith(
                    color: const Color(0xffb0d8b2),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 35,
            ),
            Text(
              "Medicine & Vitamins by Catygory",
              style: regularTextStyle.copyWith(fontSize: 16),
            ),
            const SizedBox(
              height: 15,
            ),
            GridView.builder(
              physics: const ClampingScrollPhysics(),
              itemCount: listCategory.length,
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  mainAxisExtent: 111, crossAxisCount: 4),
              itemBuilder: (context, i) {
                final x = listCategory[i];
                return CardCategory(
                  imageCategory: x.image,
                  nameCategory: x.category,
                );
              },
            ),
            const SizedBox(
              height: 35,
            ),
            GridView.builder(
              physics: const ClampingScrollPhysics(),
              itemCount: listProduct.length,
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
              ),
              itemBuilder: (context, i) {
                final y = listProduct[i];
                return CardProduct(
                  imageProduct: y.imageProduct,
                  nameProduct: y.nameProduct,
                  price: y.price,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
