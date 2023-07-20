import 'package:flutter/material.dart';

abstract class BaseConstant {
  /// app font families
  static const String worksansBold = 'Work_Sans_Bold';
  static const String worksansMedium = 'Work_Sans_Medium';
  static const String worksansRegular = 'Work_Sans_Regular';
  static const String worksansSemibold = 'Work_Sans_Semi_Bold';
  static const String worksansLight = 'Work_Sans_Light';

  abstract Color colorSurface;
  abstract Color colorOnSurface;
  abstract Color colorBackground;
  abstract Color colorOnBackground;
  abstract final Color colorOnSurfaceEmphasisHigh;
  abstract final Color colorOnSurfaceEmphasisMedium;
  abstract final Color colorOnSurfaceEmphasisDisabled;
  abstract final ThemeData themeData;

  Color colorPrimary = const Color(0xFF1568C8);
  Color colorOnPrimary = Colors.white;
  Color colorSecondary = const Color(0xff1FBD8D);
  Color colorOtherSecondary = const Color(0xff06A69D);
  Color colorOnSecondary = Colors.white;
  Color colorError = const Color(0xffFD787A);
  Color colorOnError = Colors.white;
}
