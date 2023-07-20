import 'dart:io';
import 'dart:ui';
import 'package:flutter/material.dart';

extension BuildContextExtension on BuildContext {
  Size get mediaSize => MediaQuery.of(this).size;

  ThemeData get theme => Theme.of(this);

  bool get isDarkTheme => theme.brightness == Brightness.dark;

  bool get isHaveBottomNotch => window.viewPadding.bottom > 0 && Platform.isIOS;

  double get statusBarHeight => MediaQuery.of(this).viewPadding.top;

  double get bottomNotchHeight => MediaQuery.of(this).viewPadding.bottom;
}
