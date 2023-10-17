import 'package:flutter/material.dart';

// blue color
Color get primary => const Color(0xFF1234A4);

// gray color
Color get gray01 => const Color(0XFFFBFBFB);
Color get gray02 => const Color(0XFFF7F7F7);
Color get gray03 => const Color(0XFFF5F4F3);
Color get gray04 => const Color(0XFFEFEFEF);
Color get gray05 => const Color(0XFFECECEC);
Color get gray06 => const Color(0XFFDFDFDF);
Color get gray07 => const Color(0XFFC1C1C1);
Color get gray08 => const Color(0XFFA5A5A5);
Color get gray09 => const Color(0XFF8B8B8B);
Color get gray10 => const Color(0XFF6F6F6F);
Color get gray11 => const Color(0XFF555555);
Color get gray12 => const Color(0XFF3D3D3D);
Color get gray13 => const Color(0XFF333333);
Color get gray14 => const Color(0XFF242424);
Color get gray15 => const Color(0XFF171717);
Color get black05 => Colors.black.withOpacity(0.5);
Color get black06 => Colors.black.withOpacity(0.6);

Widget get width4 => const SizedBox(width: 4);
Widget get width8 => const SizedBox(width: 8);
Widget get width12 => const SizedBox(width: 12);
Widget get width16 => const SizedBox(width: 16);
Widget get width24 => const SizedBox(width: 24);
Widget get width36 => const SizedBox(width: 36);
Widget get width48 => const SizedBox(width: 48);

Widget get height4 => const SizedBox(height: 4);
Widget get height8 => const SizedBox(height: 8);
Widget get height12 => const SizedBox(height: 12);
Widget get height16 => const SizedBox(height: 16);
Widget get height24 => const SizedBox(height: 24);
Widget get height36 => const SizedBox(height: 36);
Widget get height48 => const SizedBox(height: 48);

Gradient get captionGradient => LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [
        Colors.yellow,
        Colors.orange,
        Colors.orange,
      ],
    );

EdgeInsets get captionMargin =>
    const EdgeInsets.symmetric(horizontal: 4.0, vertical: 2.0);

BorderRadius get radius4 => const BorderRadius.all(Radius.circular(4.0));
BorderRadius get radius8 => const BorderRadius.all(Radius.circular(8.0));
BorderRadius get radius12 => const BorderRadius.all(Radius.circular(12.0));
BorderRadius get radius16 => const BorderRadius.all(Radius.circular(16.0));
BorderRadius get radius20 => const BorderRadius.all(Radius.circular(20.0));
BorderRadius get radius40 => const BorderRadius.all(Radius.circular(40.0));

// card container 구성
BorderRadius cardRadius = radius12;
EdgeInsets cardPadding =
    const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0);
EdgeInsets cardMargin = const EdgeInsets.only(bottom: 24.0);
double profileRadius = 20.0;

// shadow
List<BoxShadow> get cardShadow => [
      BoxShadow(
        offset: Offset(4, 4),
        blurRadius: 12,
        color: Colors.black.withOpacity(0.08),
      ),
    ];
