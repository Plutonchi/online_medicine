// ignore_for_file: library_private_types_in_public_api, avoid_unnecessary_containers, use_build_context_synchronously
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:online_medicine/app/data/api/url_api.dart';
import 'package:online_medicine/app/screens/screen.dart';
import '../../theme/theme.dart';
import '../../widget/custom_text_field.dart';
import '../../widget/widget.dart';
import 'package:http/http.dart' as http;

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool _seceryText = true;
  showHide() {
    setState(() {
      _seceryText = !_seceryText;
    });
  }

  submitLogin() async {
    var urlLogin = Uri.parse(BASEURL.apiLogin);
    final response = await http.post(
      urlLogin,
      body: {
        "email": emailController.text,
        "password": passwordController.text,
      },
    );
    final data = jsonDecode(response.body);
    int value = data['value'];
    String message = data['message'];
    if (value == 1) {
      showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) => AlertDialog(
          title: const Text("Information"),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const MainScreen(),
                    ),
                    (route) => false);
              },
              child: const Text("OK"),
            ),
          ],
        ),
      );
      setState(() {});
    } else {
      showDialog(
        barrierDismissible: false,
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
                const SizedBox(
                  height: 100,
                ),
                Text(
                  'LogIn',
                  style: regularTextStyle.copyWith(fontSize: 25),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  'LogIn into your account',
                  style: regularTextStyle.copyWith(
                      fontSize: 15, color: greyLightColor),
                ),
                const SizedBox(
                  height: 20,
                ),
                CustomTextField(
                  controller: emailController,
                  hintText: 'Email Address',
                ),
                const SizedBox(
                  height: 25,
                ),
                CustomTextField(
                  controller: passwordController,
                  obscureText: _seceryText,
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
                  // obscureText: _seceryText,
                  hintText: 'Password',
                ),
                const SizedBox(
                  height: 30,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: ButtonPrimary(
                    text: "LogIn",
                    onTap: () {
                      if (emailController.text.isEmpty ||
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
                        submitLogin();
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
                      "Don't have an account? ",
                      style: lightTextStyle.copyWith(
                          fontSize: 15, color: greyLightColor),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const RegisterScreen(),
                            ),
                            (route) => false);
                      },
                      child: Text(
                        'Create Account',
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
