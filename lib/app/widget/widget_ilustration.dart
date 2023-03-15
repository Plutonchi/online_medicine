import 'package:flutter/material.dart';

import '../theme/theme.dart';

class WidgetIlustration extends StatelessWidget {
  final Widget? child;
  final String title;
  final String image;

  final String subtitle1;
  final String subtitle2;

  const WidgetIlustration({
    Key? key,
    this.child,
    this.title = '',
    this.image = '',
    this.subtitle1 = '',
    this.subtitle2 = '',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 45,
        ),
        Image.asset(
          image.toString(),
          width: 250,
        ),
        const SizedBox(
          height: 30,
        ),
        Text(
          title.toString(),
          style: regularTextStyle.copyWith(fontSize: 25),
          textAlign: TextAlign.center,
        ),
        const SizedBox(
          height: 16,
        ),
        Column(
          children: [
            Text(
              subtitle1.toString(),
              style: regularTextStyle.copyWith(
                fontSize: 15,
                color: greyLightColor,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              subtitle2.toString(),
              style: regularTextStyle.copyWith(
                fontSize: 15,
                color: greyLightColor,
              ),
            ),
            const SizedBox(
              height: 60,
            ),
            child ?? const SizedBox(),
          ],
        ),
      ],
    );
  }
}
