// ignore_for_file: library_private_types_in_public_api, avoid_unnecessary_containers, use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:online_medicine/app/data/api/url_api.dart';
import 'package:online_medicine/app/theme/theme.dart';
import 'package:http/http.dart' as http;
import '../../widget/custom_text_field.dart';
import '../../widget/widget.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController fullNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool _seceryText = true;
  showHide() {
    setState(() {
      _seceryText = !_seceryText;
    });
  }

  registerSubmit() async {
    var registerUrl = Uri.parse(BASEURL.apiRegister);
    final response = await http.post(registerUrl, body: {
      'fullName': fullNameController.text,
      'email': emailController.text,
      'phone': phoneController.text,
      'address': addressController.text,
      'password': passwordController.text,
    });
    final data = jsonDecode(response.body);
    int value = data['value'];
    String message = data['message'];
    if (value == 1) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text("Information"),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("OK"),
            ),
          ],
        ),
      );
      setState(() {});
    } else {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text("Information"),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("OK"),
            ),
          ],
        ),
      );
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Container(
            child: const GeneralLogoSpace(),
          ),
          Container(
            padding: const EdgeInsets.all(25),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Register',
                  style: regularTextStyle.copyWith(fontSize: 25),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  'Register new your account',
                  style: regularTextStyle.copyWith(
                      fontSize: 15, color: greyLightColor),
                ),
                const SizedBox(
                  height: 20,
                ),
                CustomTextField(
                  controller: fullNameController,
                  hintText: 'Full Name',
                ),
                const SizedBox(
                  height: 25,
                ),
                CustomTextField(
                  controller: emailController,
                  hintText: 'Email Address',
                ),
                const SizedBox(
                  height: 25,
                ),
                CustomTextField(
                  controller: phoneController,
                  hintText: 'Phone',
                ),
                const SizedBox(
                  height: 25,
                ),
                CustomTextField(
                  controller: addressController,
                  hintText: 'Home Address',
                ),
                const SizedBox(
                  height: 25,
                ),
                CustomTextField(
                  controller: passwordController,
                  suffixIcon: IconButton(
                    onPressed: showHide,
                    icon: _seceryText
                        ? const Icon(
                            Icons.visibility,
                          )
                        : const Icon(
                            Icons.visibility_off,
                          ),
                  ),
                  obscureText: _seceryText,
                  hintText: 'Password',
                ),
                const SizedBox(
                  height: 30,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: ButtonPrimary(
                    text: "Register",
                    onTap: () {
                      if (fullNameController.text.isEmpty ||
                          emailController.text.isEmpty ||
                          phoneController.text.isEmpty ||
                          addressController.text.isEmpty ||
                          passwordController.text.isEmpty) {
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: const Text("Warning !!"),
                            content: const Text("Please, Enter the fields"),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: const Text("OK"),
                              ),
                            ],
                          ),
                        );
                      } else {
                        registerSubmit();
                      }
                    },
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Already have an account? ',
                      style: lightTextStyle.copyWith(
                          fontSize: 15, color: greyLightColor),
                    ),
                    TextButton(
                      onPressed: () {},
                      child: Text(
                        'Login Now',
                        style: boldTextStyle.copyWith(
                            fontSize: 15, color: greenColor),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
