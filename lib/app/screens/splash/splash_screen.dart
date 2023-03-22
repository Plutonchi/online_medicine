import 'package:flutter/material.dart';
import 'package:online_medicine/app/screens/screen.dart';
import 'package:online_medicine/app/widget/widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../data/model/model.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  String? userID;
  getPref() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    userID = sharedPreferences.getString(PrefProfile.idUSer);
    userID == null ? sessionsLogout() : sessionsLogin();
  }

  sessionsLogout() {}
  sessionsLogin() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const MainScreen(),
      ),
    );
  }

  @override
  void initState() {
    getPref();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GeneralLogoSpace(
        child: Column(
          children: [
            const SizedBox(
              height: 45,
            ),
            WidgetIlustration(
              image: 'assets/images/splash_ilustration.png',
              title: 'Find your medical\nsolution',
              subtitle1: 'Consult with a doctor',
              subtitle2: 'Wherever and whenever you want',
              child: ButtonPrimary(
                text: "Get Started",
                onTap: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const LoginScreen(),
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
