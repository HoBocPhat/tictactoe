import 'package:flutter/material.dart';

import 'app_colors.dart';


class AppFontWeight {

  static const light = FontWeight.w300;
  static const regular = FontWeight.w400;
  static const bold= FontWeight.w500;
}

abstract class AppStyles {
  ThemeData? themeData;

  TextStyle? defaultTextStyle();
  TextStyle? defaultTextFieldStyle();
}

class DefaultAppStyles implements AppStyles {
  @override
  ThemeData? themeData = ThemeData(
    backgroundColor: AppColors.backgroundColor,
    textTheme: const TextTheme(
      headline1: TextStyle(fontSize: 48, fontWeight: AppFontWeight.bold),
      headline4: TextStyle(fontSize: 24, fontWeight: AppFontWeight.bold),
      headline5: TextStyle(fontSize: 24, fontWeight: AppFontWeight.light),
      bodyText1: TextStyle(fontSize: 14, fontWeight: AppFontWeight.regular),
      bodyText2: TextStyle(fontSize: 10, fontWeight: AppFontWeight.regular)
    ),
    fontFamily: 'HelveticaNeue',
  );

  @override
  TextStyle? defaultTextStyle() {
    return themeData?.textTheme.bodyText2?.copyWith(color: Colors.black);
  }

  @override
  TextStyle? defaultTextFieldStyle() {
    return themeData?.textTheme.bodyText2?.copyWith(
        fontSize: 16, color: Colors.black, fontWeight: AppFontWeight.light);
  }
}
