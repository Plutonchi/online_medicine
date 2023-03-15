import 'package:flutter/material.dart';
import 'package:online_medicine/app/screens/screen.dart';
import 'package:online_medicine/app/widget/widget.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

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
                      builder: (context) => const RegisterScreen(),
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
