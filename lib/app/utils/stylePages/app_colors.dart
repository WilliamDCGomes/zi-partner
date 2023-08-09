import 'package:flutter/material.dart';

class AppColors {
  static const Color whiteColor = Colors.white;
  static final Color whiteColorWithOpacity = Colors.white.withOpacity(.5);
  static final Color whiteColorWithLessOpacity = Colors.white.withOpacity(.7);
  static final Color whiteColorWithVeryLowOpacity = Colors.white.withOpacity(.9);
  static const Color blackColor = Colors.black;
  static final Color blackTransparentColor = Colors.black.withOpacity(.6);
  static final Color black40TransparentColor = Colors.black.withOpacity(.4);
  static final Color blackWithOpacity = Colors.black.withOpacity(.6);
  static const Color transparentColor = Colors.transparent;
  static const Color defaultColor = Color(0XFFC42404);
  static final Color defaultColorWithOpacity = const Color(0XFFB6350E).withOpacity(.6);
  static const Color orangeColor = Color(0XFFEA6F55);
  static final Color orangeColorWithOpacity = const Color(0XFFEA6F55).withOpacity(.6);
  static const Color greenColor = Color(0XFF4CCC93);
  static const Color successGreenColor = Color(0XFF076D54);
  static const Color redColor = Color(0XFFC81B1B);
  static const Color grayTextColor = Color(0XFFA9A9A9);
  static const Color grayStepColor = Color(0XFFC9C9C9);
  static final Color grayStepColorWithOpacity = const Color(0XFFC9C9C9).withOpacity(.6);
  static const Color backgroundColor = Color(0XFFE7E3E3);
  static const Color grayBackgroundPictureColor = Color(0XFFB2B1B2);
  static const List<Color> backgroundFirstScreenColor = [Color(0XFFE7E3E3), Color(0XFFFFFFFF)];
}
