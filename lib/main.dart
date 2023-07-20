import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hyll_ag/ui/feed/home_feed_bloc.dart';
import 'package:hyll_ag/ui/feed/home_feed_screen.dart';
import 'package:hyll_ag/util/app_strings.dart';
import 'package:hyll_ag/util/base_constants.dart';
import 'package:hyll_ag/util/dark_theme_constant.dart';
import 'package:hyll_ag/util/light_theme_constant.dart';

final BaseConstant darkThemeConstant = DarkThemeConstant();
final BaseConstant lightThemeConstant = LightThemeConstant();

class _AppRouter {
  PageRoute _getPageRoute(Widget widget) => Platform.isIOS ? CupertinoPageRoute(builder: (_) => widget) : MaterialPageRoute(builder: (_) => widget);

  Route? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case HomeFeedScreen.route:
        {
          const screen = HomeFeedScreen();
          return _getPageRoute(BlocProvider(create: (_) => HomeFeedBloc(), child: screen));
        }
    }
    return null;
  }
}

class _AppState extends StatelessWidget {
  const _AppState();

  @override
  Widget build(BuildContext context) {
    final router = _AppRouter();

    return MaterialApp(
        onGenerateRoute: router.onGenerateRoute,
        debugShowCheckedModeBanner: false,
        themeMode: ThemeMode.system,
        title: AppStrings.APP_NAME,
        darkTheme: darkThemeConstant.themeData,
        theme: lightThemeConstant.themeData);
  }
}

void main() => runApp(const _AppState());
