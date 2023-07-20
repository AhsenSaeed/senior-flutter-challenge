import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hyll_ag/util/base_constants.dart';

class DarkThemeConstant extends BaseConstant {
  @override
  Color colorBackground = const Color(0xff2C2C2C);

  @override
  Color colorOnBackground = Colors.white;

  @override
  Color colorOnSurface = Colors.white;

  @override
  Color colorSurface = const Color(0xff2C2C2C);

  @override
  Color get colorOnSurfaceEmphasisDisabled => colorOnSurface.withAlpha(51);

  @override
  Color get colorOnSurfaceEmphasisHigh => colorOnSurface.withAlpha(230);

  @override
  Color get colorOnSurfaceEmphasisMedium => colorOnSurface.withAlpha(153);

  @override
  ThemeData get themeData => ThemeData(
      textTheme: TextTheme(
          displaySmall: TextStyle(fontFamily: BaseConstant.worksansSemibold, color: colorOnSurfaceEmphasisHigh, letterSpacing: -0.00833333333),
          headlineMedium: TextStyle(fontFamily: BaseConstant.worksansBold, color: colorOnSurfaceEmphasisHigh, letterSpacing: 0),
          headlineSmall: TextStyle(fontFamily: BaseConstant.worksansBold, color: colorOnSurfaceEmphasisHigh, letterSpacing: 0.00735294118),
          titleLarge: TextStyle(fontFamily: BaseConstant.worksansBold, color: colorOnSurfaceEmphasisHigh, letterSpacing: 0),
          titleMedium: TextStyle(fontFamily: BaseConstant.worksansMedium, color: colorOnSurfaceEmphasisHigh, letterSpacing: 0.0125),
          titleSmall: TextStyle(fontFamily: BaseConstant.worksansRegular, color: colorOnSurfaceEmphasisHigh, letterSpacing: 0.009375),
          bodyLarge: TextStyle(fontFamily: BaseConstant.worksansBold, color: colorOnSurfaceEmphasisHigh, letterSpacing: 0.00714285714),
          bodyMedium: TextStyle(fontFamily: BaseConstant.worksansBold, color: colorOnSurfaceEmphasisHigh, letterSpacing: 0.03125),
          labelLarge:
              TextStyle(fontFamily: BaseConstant.worksansRegular, color: colorOnSurfaceEmphasisHigh, fontSize: 12, letterSpacing: 0.0333333333),
          bodySmall: TextStyle(fontFamily: BaseConstant.worksansRegular, color: colorOnSurfaceEmphasisHigh, letterSpacing: 0.0178571429)),
      colorScheme: ColorScheme(
          brightness: Brightness.dark,
          primary: colorPrimary,
          onPrimary: colorOnPrimary,
          secondary: colorSecondary,
          onSecondary: colorOnSecondary,
          error: colorError,
          onError: colorOnError,
          background: colorBackground,
          onBackground: colorOnBackground,
          surface: colorSurface,
          onSurface: colorOnSurface),
      useMaterial3: true,
      cupertinoOverrideTheme: CupertinoThemeData(
          brightness: Brightness.dark, primaryColor: colorPrimary, scaffoldBackgroundColor: colorBackground, primaryContrastingColor: colorOnPrimary),
      brightness: Brightness.dark);
}
