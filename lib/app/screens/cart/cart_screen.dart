// ignore_for_file: library_private_types_in_public_api, unnecessary_null_comparison, prefer_interpolation_to_compose_strings, avoid_print

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:online_medicine/app/data/api/url_api.dart';
import 'package:online_medicine/app/data/model/model.dart';
import 'package:online_medicine/app/screens/main/main_screen.dart';
import 'package:online_medicine/app/theme/theme.dart';
import 'package:online_medicine/app/widget/widget.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final price = NumberFormat("#,##0", "en_US");

  String? userId, fullName, address, phone;
  int delivery = 0;
  getPref() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      userId = sharedPreferences.getString(PrefProfile.idUSer);
      fullName = sharedPreferences.getString(PrefProfile.name);
      address = sharedPreferences.getString(PrefProfile.address);
      phone = sharedPreferences.getString(PrefProfile.phone);
    });
    getCart();
    cartTotalPrice();
  }

  List<CartModel> listcart = [];
  getCart() async {
    listcart.clear();
    var urlGetCart = Uri.parse(BASEURL.getProductCart + userId!);
    final response = await http.get(urlGetCart);
    if (response.statusCode == 200) {
      setState(() {
        final data = jsonDecode(response.body);
        for (Map item in data) {
          listcart.add(CartModel.fromJson(item));
        }
      });
    }
  }

  updateQuantity(String tipe, String model) async {
    var urlUpadteQuantity = Uri.parse(BASEURL.updateQuantityProduct);
    final response = await http.post(
      urlUpadteQuantity,
      body: {
        "cartID": model,
        "tipe": tipe,
      },
    );
    final data = jsonDecode(response.body);
    int value = data['value'];
    String message = data['message'];
    if (value == 1) {
      print(message);
      setState(() {
        getPref();
      });
    } else {
      print(message);
      setState(() {
        getPref();
      });
    }
  }

  var sumPrice = '0';
  int totalpayment = 0;
  cartTotalPrice() async {
    var totalPrice = Uri.parse(BASEURL.totalPrice + userId!);
    final responce = await http.get(totalPrice);
    if (responce.statusCode == 200) {
      final data = jsonDecode(responce.body);
      String total = data['Total'];
      setState(() {
        sumPrice = total;
        totalpayment = sumPrice == null ? 0 : int.parse(sumPrice) + delivery;
      });
      print(sumPrice);
    }
  }

  @override
  void initState() {
    getPref();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: listcart.isEmpty
          ? const SizedBox()
          : Container(
              height: 220,
              padding: const EdgeInsets.all(25),
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(
                color: Color(0xfffcfcfc),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Total Items",
                        style: regularTextStyle.copyWith(
                            fontSize: 16, color: greyBoldColor),
                      ),
                      Text(
                        "KGS " +
                            price.format(
                              int.parse(sumPrice),
                            ),
                        style: boldTextStyle.copyWith(fontSize: 16),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Delivery Fee",
                        style: regularTextStyle.copyWith(
                            fontSize: 16, color: greyBoldColor),
                      ),
                      Text(
                        delivery == 0 ? "FREE" : delivery.toString(),
                        style: boldTextStyle.copyWith(fontSize: 16),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Total Payment",
                        style: regularTextStyle.copyWith(
                            fontSize: 16, color: greyBoldColor),
                      ),
                      Text(
                        "KGS " + price.format(totalpayment),
                        style: boldTextStyle.copyWith(fontSize: 16),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: ButtonPrimary(
                      text: 'CHECKOUT NOW',
                      onTap: () {},
                    ),
                  ),
                ],
              ),
            ),
      body: SafeArea(
        child: ListView(
          padding: listcart.isEmpty
              ? EdgeInsets.zero
              : const EdgeInsets.only(bottom: 220),
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
                    'My Cart',
                    style: regularTextStyle.copyWith(fontSize: 25),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            listcart.isEmpty || listcart.length == null
                ? Container(
                    padding: const EdgeInsets.all(20),
                    margin: const EdgeInsets.only(top: 30),
                    child: WidgetIlustration(
                      image: 'assets/images/empty_cart_ilustration.png',
                      title: 'Oops, there are no products in your cart',
                      subtitle1: 'Your cart is still empty, browse the',
                      subtitle2: 'attractive products from MEDHEALTH',
                      child: Container(
                        margin: const EdgeInsets.only(top: 30),
                        width: MediaQuery.of(context).size.width,
                        child: ButtonPrimary(
                          text: "Shopping Now",
                          onTap: () {
                            Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const MainScreen()),
                                (route) => false);
                          },
                        ),
                      ),
                    ),
                  )
                : Container(
                    padding: const EdgeInsets.all(20),
                    height: 166,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Delivery Destination",
                          style: regularTextStyle.copyWith(fontSize: 18),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Name",
                              style: regularTextStyle.copyWith(
                                  fontSize: 16, color: greyBoldColor),
                            ),
                            Text(
                              "$fullName",
                              style: regularTextStyle.copyWith(fontSize: 16),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Address",
                              style: regularTextStyle.copyWith(
                                  fontSize: 16, color: greyBoldColor),
                            ),
                            Text(
                              "$address",
                              style: regularTextStyle.copyWith(fontSize: 16),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Phone",
                              style: regularTextStyle.copyWith(
                                  fontSize: 16, color: greyBoldColor),
                            ),
                            Text(
                              "$phone",
                              style: regularTextStyle.copyWith(fontSize: 16),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
            ListView.builder(
              shrinkWrap: true,
              physics: const ClampingScrollPhysics(),
              itemCount: listcart.length,
              itemBuilder: (context, i) {
                final x = listcart[i];
                return Container(
                  padding: const EdgeInsets.all(25),
                  color: whiteColor,
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Image.network(
                            x.image,
                            width: 115,
                            height: 100,
                            fit: BoxFit.cover,
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width - 200,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  x.name,
                                  style:
                                      regularTextStyle.copyWith(fontSize: 16),
                                ),
                                Row(
                                  children: [
                                    IconButton(
                                      onPressed: () {
                                        updateQuantity('add', x.idCart);
                                      },
                                      icon: Icon(
                                        Icons.add_circle,
                                        color: greenColor,
                                      ),
                                    ),
                                    Text(x.quantity),
                                    IconButton(
                                      onPressed: () {
                                        updateQuantity('remove', x.idCart);
                                      },
                                      icon: const Icon(
                                        Icons.remove_circle,
                                        color: Color(0xfff0997a),
                                      ),
                                    ),
                                  ],
                                ),
                                Text(
                                  "KGS " + price.format(int.parse(x.price)),
                                  style: boldTextStyle.copyWith(fontSize: 16),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const Divider(),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
