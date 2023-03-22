// ignore_for_file: sized_box_for_whitespace, library_private_types_in_public_api, avoid_function_literals_in_foreach_calls, prefer_is_empty

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:online_medicine/app/data/model/model.dart';
import 'package:online_medicine/app/screens/screen.dart';
import 'package:online_medicine/app/theme/theme.dart';
import 'package:http/http.dart' as http;
import 'package:online_medicine/app/widget/widget.dart';
import '../../data/api/url_api.dart';

class SearchProduct extends StatefulWidget {
  const SearchProduct({Key? key}) : super(key: key);

  @override
  _SearchProductState createState() => _SearchProductState();
}

class _SearchProductState extends State<SearchProduct> {
  TextEditingController searchController = TextEditingController();
  List<ProductModel> listProduct = [];
  List<ProductModel> listSearchProduct = [];

  getProduct() async {
    listProduct.clear();
    var urlProduct = Uri.parse(BASEURL.getProduct);
    final response = await http.get(urlProduct);
    if (response.statusCode == 200) {
      setState(() {
        final data = jsonDecode(response.body);
        for (Map<String, dynamic> product in data) {
          listProduct.add(
            ProductModel.fromJson(product),
          );
        }
      });
    }
  }

  searchProduct(String text) {
    listSearchProduct.clear();
    if (text.isEmpty) {
      setState(() {});
    } else {
      listProduct.forEach((element) {
        if (element.nameProduct.toLowerCase().contains(text)) {
          listSearchProduct.add(element);
        }
      });
      setState(() {});
    }
  }

  @override
  void initState() {
    getProduct();
    super.initState();
  }

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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    width: MediaQuery.of(context).size.width - 96,
                    height: 55,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: const Color(
                        0xffe4faf0,
                      ),
                    ),
                    child: TextField(
                      autofocus: true,
                      onChanged: searchProduct,
                      controller: searchController,
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
                ],
              ),
            ),
            searchController.text.isEmpty || listSearchProduct.length == 0
                ? const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24, vertical: 80),
                    child: WidgetIlustration(
                      image: 'assets/images/no_data_ilustration.png',
                      title: "There is no medicine that is looking for",
                      subtitle1: "Please find the product you want,",
                      subtitle2: "the product will appear here",
                    ),
                  )
                : Container(
                    padding: const EdgeInsets.all(24),
                    child: GridView.builder(
                      physics: const ClampingScrollPhysics(),
                      itemCount: listSearchProduct.length,
                      shrinkWrap: true,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 16,
                        mainAxisSpacing: 20,
                      ),
                      itemBuilder: (context, i) {
                        final y = listSearchProduct[i];
                        return InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => DetailProduct(y),
                              ),
                            );
                          },
                          child: CardProduct(
                            imageProduct: y.imageProduct,
                            nameProduct: y.nameProduct,
                            price: y.price,
                          ),
                        );
                      },
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
